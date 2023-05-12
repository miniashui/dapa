{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.PositionSample where
import SMACCMPilot.Comm.Native.Types.GpsFix
import Data.Word
import Data.Int
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data PositionSample =
  PositionSample
    { fix :: GpsFix
    , num_sv :: Word8
    , dop :: Float
    , lat :: Int32
    , lon :: Int32
    , alt :: Int32
    , vnorth :: Int32
    , veast :: Int32
    , vdown :: Int32
    , vground :: Word32
    , heading :: Float
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putPositionSample :: Putter PositionSample
putPositionSample PositionSample{..} = do
  putGpsFix fix
  putWord8 num_sv
  putFloat32be dop
  put lat
  put lon
  put alt
  put vnorth
  put veast
  put vdown
  putWord32be vground
  putFloat32be heading
  putTimeMicros time
getPositionSample :: Get PositionSample
getPositionSample = do
  fix <- getGpsFix
  num_sv <- getWord8
  dop <- getFloat32be
  lat <- get
  lon <- get
  alt <- get
  vnorth <- get
  veast <- get
  vdown <- get
  vground <- getWord32be
  heading <- getFloat32be
  time <- getTimeMicros
  return PositionSample{..}
instance Serialize PositionSample where
  put = putPositionSample
  get = getPositionSample
arbitraryPositionSample :: Q.Gen PositionSample
arbitraryPositionSample = do
  fix <- Q.arbitrary
  num_sv <- Q.arbitrary
  dop <- Q.arbitrary
  lat <- Q.arbitrary
  lon <- Q.arbitrary
  alt <- Q.arbitrary
  vnorth <- Q.arbitrary
  veast <- Q.arbitrary
  vdown <- Q.arbitrary
  vground <- Q.arbitrary
  heading <- Q.arbitrary
  time <- Q.arbitrary
  return PositionSample{..}
instance Q.Arbitrary PositionSample where
  arbitrary = arbitraryPositionSample
instance ToJSON PositionSample
instance FromJSON PositionSample