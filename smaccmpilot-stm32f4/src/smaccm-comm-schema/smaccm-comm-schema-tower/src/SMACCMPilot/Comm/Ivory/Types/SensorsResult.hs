{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SensorsResult where
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.Quaternion as Quaternion
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sensors_result
  { valid :: (Stored IBool)
  ; roll :: (Stored IFloat)
  ; pitch :: (Stored IFloat)
  ; yaw :: (Stored IFloat)
  ; omega :: Struct xyz
  ; attitude :: Struct quaternion
  ; baro_alt :: (Stored IFloat)
  ; lidar_alt :: (Stored IFloat)
  ; sonar_alt :: (Stored IFloat)
  ; accel :: Struct xyz
  ; ahrs_time :: (Stored TimeMicros.TimeMicros)
  ; baro_time :: (Stored TimeMicros.TimeMicros)
  ; lidar_time :: (Stored TimeMicros.TimeMicros)
  }
|]
packSensorsResult :: WrappedPackRep ('Struct "sensors_result")
packSensorsResult = wrapPackRep "sensors_result" $
  packStruct [ packLabel valid
             , packLabel roll
             , packLabel pitch
             , packLabel yaw
             , packLabel omega
             , packLabel attitude
             , packLabel baro_alt
             , packLabel lidar_alt
             , packLabel sonar_alt
             , packLabel accel
             , packLabel ahrs_time
             , packLabel baro_time
             , packLabel lidar_time
             ]
instance Packable ('Struct "sensors_result") where
  packRep = wrappedPackRep packSensorsResult
sensorsResultTypesModule :: Module
sensorsResultTypesModule = package "sensors_result_types" $ do
  defStruct (Proxy :: Proxy "sensors_result")
  depend serializeModule
  wrappedPackMod packSensorsResult
  depend Xyz.xyzTypesModule
  depend Quaternion.quaternionTypesModule
  depend TimeMicros.timeMicrosTypesModule