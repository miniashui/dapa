{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.AccelerometerSample where
import SMACCMPilot.Comm.Native.Types.Xyz
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data AccelerometerSample =
  AccelerometerSample
    { initfail :: Bool
    , samplefail :: Bool
    , sample :: Xyz
    , temperature :: Float
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putAccelerometerSample :: Putter AccelerometerSample
putAccelerometerSample AccelerometerSample{..} = do
  put initfail
  put samplefail
  putXyz sample
  putFloat32be temperature
  putTimeMicros time
getAccelerometerSample :: Get AccelerometerSample
getAccelerometerSample = do
  initfail <- get
  samplefail <- get
  sample <- getXyz
  temperature <- getFloat32be
  time <- getTimeMicros
  return AccelerometerSample{..}
instance Serialize AccelerometerSample where
  put = putAccelerometerSample
  get = getAccelerometerSample
arbitraryAccelerometerSample :: Q.Gen AccelerometerSample
arbitraryAccelerometerSample = do
  initfail <- Q.arbitrary
  samplefail <- Q.arbitrary
  sample <- Q.arbitrary
  temperature <- Q.arbitrary
  time <- Q.arbitrary
  return AccelerometerSample{..}
instance Q.Arbitrary AccelerometerSample where
  arbitrary = arbitraryAccelerometerSample
instance ToJSON AccelerometerSample
instance FromJSON AccelerometerSample