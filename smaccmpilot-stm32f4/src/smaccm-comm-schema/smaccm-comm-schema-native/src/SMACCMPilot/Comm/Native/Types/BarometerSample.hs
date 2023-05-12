{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.BarometerSample where
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data BarometerSample =
  BarometerSample
    { initfail :: Bool
    , samplefail :: Bool
    , pressure :: Float
    , temperature :: Float
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putBarometerSample :: Putter BarometerSample
putBarometerSample BarometerSample{..} = do
  put initfail
  put samplefail
  putFloat32be pressure
  putFloat32be temperature
  putTimeMicros time
getBarometerSample :: Get BarometerSample
getBarometerSample = do
  initfail <- get
  samplefail <- get
  pressure <- getFloat32be
  temperature <- getFloat32be
  time <- getTimeMicros
  return BarometerSample{..}
instance Serialize BarometerSample where
  put = putBarometerSample
  get = getBarometerSample
arbitraryBarometerSample :: Q.Gen BarometerSample
arbitraryBarometerSample = do
  initfail <- Q.arbitrary
  samplefail <- Q.arbitrary
  pressure <- Q.arbitrary
  temperature <- Q.arbitrary
  time <- Q.arbitrary
  return BarometerSample{..}
instance Q.Arbitrary BarometerSample where
  arbitrary = arbitraryBarometerSample
instance ToJSON BarometerSample
instance FromJSON BarometerSample