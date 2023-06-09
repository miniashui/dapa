-- vim: ft=haskell

{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module SMACCMPilot.Comm.Native.Rpc.Base where

import qualified Data.ByteString.Lazy as LBS
import           Data.Word (Word32)
import           Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import           Data.Time
                     (UTCTime,diffUTCTime,formatTime
                      ,getCurrentTime, utcToLocalZonedTime)
import           Data.Time.Locale.Compat
import           Control.Applicative ((<|>))
import           Control.Concurrent (forkIO)
import           Control.Concurrent.STM
                     (atomically,STM,TVar,newTVar,writeTVar,readTVar
                     ,TQueue,readTQueue,writeTQueue
                     ,TMVar,newEmptyTMVarIO,takeTMVar,putTMVar,newTVarIO
                     ,modifyTVar)
import           Control.Monad (forever)
import           Control.Monad.IO.Class (liftIO)
import           System.IO
                     (openFile,hFlush,hPutStr,hPutStrLn,IOMode(WriteMode)
                     ,Handle)
import           Snap.Core (MonadSnap,Snap)
import qualified Snap.Core as Snap
import qualified Snap.Http.Server as HTTP
import           Snap.Util.FileServe (serveDirectory)

data Config = Config { cfgPort :: !Int
                       -- ^ The port to run on

                     , cfgStaticDir :: Maybe FilePath
                       -- ^ Content to be served off of the root, relative to
                       -- the directory that the server was started in

                     , cfgLogSuffix :: Maybe FilePath
                       -- ^ Suffix for the JSON response log file
                     } deriving (Show)

-- | A default @Config@ value that will produce a server that runs on port 8080,
-- serves no static content, and does no logging.
defaultConfig :: Config
defaultConfig  = Config {
    cfgPort = 8080
  , cfgStaticDir = Nothing
  , cfgLogSuffix = Nothing
  }


-- | Spawn a snap server, and run the given RPC action.
runServer :: Config -> Snap () -> IO ()
runServer Config { .. } serveRpc =
  do let snapCfg :: HTTP.Config Snap ()
         snapCfg  = HTTP.setPort cfgPort HTTP.defaultConfig
     HTTP.simpleHttpServe snapCfg body
  where
  body = case cfgStaticDir of
    Just path -> serveDirectory path <|> serveRpc
    Nothing -> serveRpc

data Request req resp = ReadRequest req (resp -> IO ())
                      | WriteRequest req


-- Sample Variables ------------------------------------------------------------

-- | A TVar that blocks when it's empty, but allows writes even when it's full.
newtype TSampleVar a = TSampleVar (TVar (Maybe a))

newTSampleVar :: STM (TSampleVar a)
newTSampleVar  = TSampleVar `fmap` newTVar Nothing

newTSampleVarIO :: IO (TSampleVar a)
newTSampleVarIO  = atomically (TSampleVar `fmap` newTVar Nothing)

writeTSampleVar :: TSampleVar a -> a -> STM ()
writeTSampleVar (TSampleVar tv) a = writeTVar tv (Just a)

readTSampleVar :: TSampleVar a -> STM (Maybe a)
readTSampleVar (TSampleVar tv) = readTVar tv

-- Response Handling -----------------------------------------------------------

data Conn req resp = Conn { connRequests :: TQueue req
                          , connWaiting  :: TVar (Map Word32 (TMVar resp))
                          , connSeqNum   :: TVar Word32
                          }


-- | Fork a handler thread that will apply handlers to incoming messages.  If
-- the handler queue is empty when a response arrives, the response is dropped.
newConn :: TQueue req -> TQueue resp -> (resp -> Word32) -> IO (Conn req resp)
newConn connRequests connResps toSeqNum =
  do connWaiting <- newTVarIO Map.empty
     connSeqNum  <- newTVarIO 0

     _ <- forkIO (forever
        (do resp <- atomically (readTQueue connResps)
            let snum = toSeqNum resp
            mb   <- atomically (do
                     m <- readTVar connWaiting
                     let (mb, m') = Map.updateLookupWithKey (\_ _ -> Nothing) snum m
                     writeTVar connWaiting m'
                     return mb)
            case mb of
              Just var -> atomically (putTMVar var resp)
              Nothing  -> return ()))

     return Conn { .. }


-- | Send a request, and block until a response is received.
sendRequest :: Conn req resp -> (Word32 -> req) -> IO resp
sendRequest Conn { .. } req =
  do var <- newEmptyTMVarIO

     atomically (do snum <- readTVar connSeqNum
                    writeTVar connSeqNum (snum + 1)
                    modifyTVar connWaiting (Map.insert snum var)
                    writeTQueue connRequests (req snum))

     atomically (takeTMVar var)

-- Logging Helpers -------------------------------------------------------------

type LoggingContext = (UTCTime, Maybe Handle)

initLogging :: Maybe FilePath -> IO LoggingContext
initLogging mfp = do
  t0 <- getCurrentTime
  t0local <- utcToLocalZonedTime t0
  let startFmt = formatTime defaultTimeLocale "%Y-%m-%d-%H%M%S" t0local
  mLog <- case mfp of
            Nothing -> return Nothing
            Just logSuffix -> do
              h <- openFile (startFmt ++ "-" ++ logSuffix) WriteMode
              hPutStrLn h startFmt
              return (Just h)
  return (t0, mLog)

writeLoggingLBS :: MonadSnap m => LoggingContext -> LBS.ByteString -> m ()
writeLoggingLBS (_, Nothing) lbs = Snap.writeLBS lbs
writeLoggingLBS (t0, Just h) lbs = do
  liftIO (do
    t <- getCurrentTime
    let now = takeWhile (/= 's') (show (diffUTCTime t t0))
    hPutStr h (now ++ ":")
    LBS.hPut h (LBS.append lbs "\n")
    hFlush h)
  Snap.writeLBS lbs