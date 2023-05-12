{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample where
import Data.Word
import Data.Int
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Px4flowIntegralSample =
  Px4flowIntegralSample
    { frame_count_since_last_readout :: Word16
    , pixel_flow_x_integral :: Int16
    , pixel_flow_y_integral :: Int16
    , gyro_x_rate_integral :: Int16
    , gyro_y_rate_integral :: Int16
    , gyro_z_rate_integral :: Int16
    , integration_timespan :: Word32
    , sonar_timestamp :: Word32
    , ground_distance :: Int16
    , gyro_temperature :: Int16
    , quality :: Word8
    , samplefail :: Bool
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putPx4flowIntegralSample :: Putter Px4flowIntegralSample
putPx4flowIntegralSample Px4flowIntegralSample{..} = do
  putWord16be frame_count_since_last_readout
  put pixel_flow_x_integral
  put pixel_flow_y_integral
  put gyro_x_rate_integral
  put gyro_y_rate_integral
  put gyro_z_rate_integral
  putWord32be integration_timespan
  putWord32be sonar_timestamp
  put ground_distance
  put gyro_temperature
  putWord8 quality
  put samplefail
  putTimeMicros time
getPx4flowIntegralSample :: Get Px4flowIntegralSample
getPx4flowIntegralSample = do
  frame_count_since_last_readout <- getWord16be
  pixel_flow_x_integral <- get
  pixel_flow_y_integral <- get
  gyro_x_rate_integral <- get
  gyro_y_rate_integral <- get
  gyro_z_rate_integral <- get
  integration_timespan <- getWord32be
  sonar_timestamp <- getWord32be
  ground_distance <- get
  gyro_temperature <- get
  quality <- getWord8
  samplefail <- get
  time <- getTimeMicros
  return Px4flowIntegralSample{..}
instance Serialize Px4flowIntegralSample where
  put = putPx4flowIntegralSample
  get = getPx4flowIntegralSample
arbitraryPx4flowIntegralSample :: Q.Gen Px4flowIntegralSample
arbitraryPx4flowIntegralSample = do
  frame_count_since_last_readout <- Q.arbitrary
  pixel_flow_x_integral <- Q.arbitrary
  pixel_flow_y_integral <- Q.arbitrary
  gyro_x_rate_integral <- Q.arbitrary
  gyro_y_rate_integral <- Q.arbitrary
  gyro_z_rate_integral <- Q.arbitrary
  integration_timespan <- Q.arbitrary
  sonar_timestamp <- Q.arbitrary
  ground_distance <- Q.arbitrary
  gyro_temperature <- Q.arbitrary
  quality <- Q.arbitrary
  samplefail <- Q.arbitrary
  time <- Q.arbitrary
  return Px4flowIntegralSample{..}
instance Q.Arbitrary Px4flowIntegralSample where
  arbitrary = arbitraryPx4flowIntegralSample
instance ToJSON Px4flowIntegralSample
instance FromJSON Px4flowIntegralSample