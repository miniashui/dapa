{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Px4ioAlarms where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct px4io_alarms
  { vservo_fault :: (Stored IBool)
  ; pwm_error :: (Stored IBool)
  ; rc_lost :: (Stored IBool)
  ; fmu_lost :: (Stored IBool)
  ; acc_current :: (Stored IBool)
  ; servo_current :: (Stored IBool)
  ; temperature :: (Stored IBool)
  ; vbatt_low :: (Stored IBool)
  }
|]
packPx4ioAlarms :: WrappedPackRep ('Struct "px4io_alarms")
packPx4ioAlarms = wrapPackRep "px4io_alarms" $
  packStruct [ packLabel vservo_fault
             , packLabel pwm_error
             , packLabel rc_lost
             , packLabel fmu_lost
             , packLabel acc_current
             , packLabel servo_current
             , packLabel temperature
             , packLabel vbatt_low
             ]
instance Packable ('Struct "px4io_alarms") where
  packRep = wrappedPackRep packPx4ioAlarms
px4ioAlarmsTypesModule :: Module
px4ioAlarmsTypesModule = package "px4io_alarms_types" $ do
  defStruct (Proxy :: Proxy "px4io_alarms")
  depend serializeModule
  wrappedPackMod packPx4ioAlarms