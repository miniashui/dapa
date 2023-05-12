{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.LidarliteSample where
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data LidarliteSample =
  LidarliteSample
    { samplefail :: Bool
    , distance :: Float
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putLidarliteSample :: Putter LidarliteSample
putLidarliteSample LidarliteSample{..} = do
  put samplefail
  putFloat32be distance
  putTimeMicros time
getLidarliteSample :: Get LidarliteSample
getLidarliteSample = do
  samplefail <- get
  distance <- getFloat32be
  time <- getTimeMicros
  return LidarliteSample{..}
instance Serialize LidarliteSample where
  put = putLidarliteSample
  get = getLidarliteSample
arbitraryLidarliteSample :: Q.Gen LidarliteSample
arbitraryLidarliteSample = do
  samplefail <- Q.arbitrary
  distance <- Q.arbitrary
  time <- Q.arbitrary
  return LidarliteSample{..}
instance Q.Arbitrary LidarliteSample where
  arbitrary = arbitraryLidarliteSample
instance ToJSON LidarliteSample
instance FromJSON LidarliteSample