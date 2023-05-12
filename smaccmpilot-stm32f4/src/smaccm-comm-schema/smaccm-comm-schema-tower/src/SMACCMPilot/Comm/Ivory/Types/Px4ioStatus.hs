{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Px4ioStatus where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct px4io_status
  { safety_off :: (Stored IBool)
  ; failsafe :: (Stored IBool)
  ; init_ok :: (Stored IBool)
  ; arm_sync :: (Stored IBool)
  ; mixer_ok :: (Stored IBool)
  ; raw_pwm :: (Stored IBool)
  ; fmu_ok :: (Stored IBool)
  ; rc_sbus :: (Stored IBool)
  ; rc_dsm :: (Stored IBool)
  ; rc_ppm :: (Stored IBool)
  ; rc_ok :: (Stored IBool)
  ; outputs_armed :: (Stored IBool)
  ; override :: (Stored IBool)
  }
|]
packPx4ioStatus :: WrappedPackRep ('Struct "px4io_status")
packPx4ioStatus = wrapPackRep "px4io_status" $
  packStruct [ packLabel safety_off
             , packLabel failsafe
             , packLabel init_ok
             , packLabel arm_sync
             , packLabel mixer_ok
             , packLabel raw_pwm
             , packLabel fmu_ok
             , packLabel rc_sbus
             , packLabel rc_dsm
             , packLabel rc_ppm
             , packLabel rc_ok
             , packLabel outputs_armed
             , packLabel override
             ]
instance Packable ('Struct "px4io_status") where
  packRep = wrappedPackRep packPx4ioStatus
px4ioStatusTypesModule :: Module
px4ioStatusTypesModule = package "px4io_status_types" $ do
  defStruct (Proxy :: Proxy "px4io_status")
  depend serializeModule
  wrappedPackMod packPx4ioStatus