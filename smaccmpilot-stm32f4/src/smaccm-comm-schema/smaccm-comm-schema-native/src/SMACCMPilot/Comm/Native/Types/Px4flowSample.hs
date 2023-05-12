{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Px4flowSample where
import Data.Word
import Data.Int
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Px4flowSample =
  Px4flowSample
    { frame_count :: Word16
    , pixel_flow_x_sum :: Int16
    , pixel_flow_y_sum :: Int16
    , flow_comp_m_x :: Int16
    , flow_comp_m_y :: Int16
    , quality :: Int16
    , gyro_x_rate :: Int16
    , gyro_y_rate :: Int16
    , gyro_z_rate :: Int16
    , gyro_range :: Word8
    , sonar_timestamp :: Word8
    , ground_distance :: Int16
    , samplefail :: Bool
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putPx4flowSample :: Putter Px4flowSample
putPx4flowSample Px4flowSample{..} = do
  putWord16be frame_count
  put pixel_flow_x_sum
  put pixel_flow_y_sum
  put flow_comp_m_x
  put flow_comp_m_y
  put quality
  put gyro_x_rate
  put gyro_y_rate
  put gyro_z_rate
  putWord8 gyro_range
  putWord8 sonar_timestamp
  put ground_distance
  put samplefail
  putTimeMicros time
getPx4flowSample :: Get Px4flowSample
getPx4flowSample = do
  frame_count <- getWord16be
  pixel_flow_x_sum <- get
  pixel_flow_y_sum <- get
  flow_comp_m_x <- get
  flow_comp_m_y <- get
  quality <- get
  gyro_x_rate <- get
  gyro_y_rate <- get
  gyro_z_rate <- get
  gyro_range <- getWord8
  sonar_timestamp <- getWord8
  ground_distance <- get
  samplefail <- get
  time <- getTimeMicros
  return Px4flowSample{..}
instance Serialize Px4flowSample where
  put = putPx4flowSample
  get = getPx4flowSample
arbitraryPx4flowSample :: Q.Gen Px4flowSample
arbitraryPx4flowSample = do
  frame_count <- Q.arbitrary
  pixel_flow_x_sum <- Q.arbitrary
  pixel_flow_y_sum <- Q.arbitrary
  flow_comp_m_x <- Q.arbitrary
  flow_comp_m_y <- Q.arbitrary
  quality <- Q.arbitrary
  gyro_x_rate <- Q.arbitrary
  gyro_y_rate <- Q.arbitrary
  gyro_z_rate <- Q.arbitrary
  gyro_range <- Q.arbitrary
  sonar_timestamp <- Q.arbitrary
  ground_distance <- Q.arbitrary
  samplefail <- Q.arbitrary
  time <- Q.arbitrary
  return Px4flowSample{..}
instance Q.Arbitrary Px4flowSample where
  arbitrary = arbitraryPx4flowSample
instance ToJSON Px4flowSample
instance FromJSON Px4flowSample