{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.MagnetometerSample where
import SMACCMPilot.Comm.Native.Types.Xyz
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data MagnetometerSample =
  MagnetometerSample
    { initfail :: Bool
    , samplefail :: Bool
    , sample :: Xyz
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putMagnetometerSample :: Putter MagnetometerSample
putMagnetometerSample MagnetometerSample{..} = do
  put initfail
  put samplefail
  putXyz sample
  putTimeMicros time
getMagnetometerSample :: Get MagnetometerSample
getMagnetometerSample = do
  initfail <- get
  samplefail <- get
  sample <- getXyz
  time <- getTimeMicros
  return MagnetometerSample{..}
instance Serialize MagnetometerSample where
  put = putMagnetometerSample
  get = getMagnetometerSample
arbitraryMagnetometerSample :: Q.Gen MagnetometerSample
arbitraryMagnetometerSample = do
  initfail <- Q.arbitrary
  samplefail <- Q.arbitrary
  sample <- Q.arbitrary
  time <- Q.arbitrary
  return MagnetometerSample{..}
instance Q.Arbitrary MagnetometerSample where
  arbitrary = arbitraryMagnetometerSample
instance ToJSON MagnetometerSample
instance FromJSON MagnetometerSample