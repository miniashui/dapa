{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.GyroscopeSample where
import SMACCMPilot.Comm.Native.Types.Xyz
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data GyroscopeSample =
  GyroscopeSample
    { initfail :: Bool
    , samplefail :: Bool
    , sample :: Xyz
    , temperature :: Float
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putGyroscopeSample :: Putter GyroscopeSample
putGyroscopeSample GyroscopeSample{..} = do
  put initfail
  put samplefail
  putXyz sample
  putFloat32be temperature
  putTimeMicros time
getGyroscopeSample :: Get GyroscopeSample
getGyroscopeSample = do
  initfail <- get
  samplefail <- get
  sample <- getXyz
  temperature <- getFloat32be
  time <- getTimeMicros
  return GyroscopeSample{..}
instance Serialize GyroscopeSample where
  put = putGyroscopeSample
  get = getGyroscopeSample
arbitraryGyroscopeSample :: Q.Gen GyroscopeSample
arbitraryGyroscopeSample = do
  initfail <- Q.arbitrary
  samplefail <- Q.arbitrary
  sample <- Q.arbitrary
  temperature <- Q.arbitrary
  time <- Q.arbitrary
  return GyroscopeSample{..}
instance Q.Arbitrary GyroscopeSample where
  arbitrary = arbitraryGyroscopeSample
instance ToJSON GyroscopeSample
instance FromJSON GyroscopeSample