{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.TimeMicros where
import Data.Int
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
newtype TimeMicros =
  TimeMicros { unTimeMicros :: Int64
             } deriving (Eq, Show, Data, Typeable, Generic)
putTimeMicros :: Putter TimeMicros
putTimeMicros (TimeMicros a) = put a
getTimeMicros :: Get TimeMicros
getTimeMicros = do
  a <- get
  return (TimeMicros a)
instance Serialize TimeMicros where
  put = putTimeMicros
  get = getTimeMicros
arbitraryTimeMicros :: Q.Gen TimeMicros
arbitraryTimeMicros = do
  a <- Q.arbitrary
  return (TimeMicros a)
instance Q.Arbitrary TimeMicros where
  arbitrary = arbitraryTimeMicros
instance ToJSON TimeMicros
instance FromJSON TimeMicros