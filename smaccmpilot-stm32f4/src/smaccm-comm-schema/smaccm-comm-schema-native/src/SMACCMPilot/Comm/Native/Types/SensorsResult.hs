{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SensorsResult where
import SMACCMPilot.Comm.Native.Types.Xyz
import SMACCMPilot.Comm.Native.Types.Quaternion
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SensorsResult =
  SensorsResult
    { valid :: Bool
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    , omega :: Xyz
    , attitude :: Quaternion
    , baro_alt :: Float
    , lidar_alt :: Float
    , sonar_alt :: Float
    , accel :: Xyz
    , ahrs_time :: TimeMicros
    , baro_time :: TimeMicros
    , lidar_time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putSensorsResult :: Putter SensorsResult
putSensorsResult SensorsResult{..} = do
  put valid
  putFloat32be roll
  putFloat32be pitch
  putFloat32be yaw
  putXyz omega
  putQuaternion attitude
  putFloat32be baro_alt
  putFloat32be lidar_alt
  putFloat32be sonar_alt
  putXyz accel
  putTimeMicros ahrs_time
  putTimeMicros baro_time
  putTimeMicros lidar_time
getSensorsResult :: Get SensorsResult
getSensorsResult = do
  valid <- get
  roll <- getFloat32be
  pitch <- getFloat32be
  yaw <- getFloat32be
  omega <- getXyz
  attitude <- getQuaternion
  baro_alt <- getFloat32be
  lidar_alt <- getFloat32be
  sonar_alt <- getFloat32be
  accel <- getXyz
  ahrs_time <- getTimeMicros
  baro_time <- getTimeMicros
  lidar_time <- getTimeMicros
  return SensorsResult{..}
instance Serialize SensorsResult where
  put = putSensorsResult
  get = getSensorsResult
arbitrarySensorsResult :: Q.Gen SensorsResult
arbitrarySensorsResult = do
  valid <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  yaw <- Q.arbitrary
  omega <- Q.arbitrary
  attitude <- Q.arbitrary
  baro_alt <- Q.arbitrary
  lidar_alt <- Q.arbitrary
  sonar_alt <- Q.arbitrary
  accel <- Q.arbitrary
  ahrs_time <- Q.arbitrary
  baro_time <- Q.arbitrary
  lidar_time <- Q.arbitrary
  return SensorsResult{..}
instance Q.Arbitrary SensorsResult where
  arbitrary = arbitrarySensorsResult
instance ToJSON SensorsResult
instance FromJSON SensorsResult