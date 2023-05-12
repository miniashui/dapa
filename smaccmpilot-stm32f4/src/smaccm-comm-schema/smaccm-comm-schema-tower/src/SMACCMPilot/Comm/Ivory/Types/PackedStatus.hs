{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.PackedStatus where
import qualified SMACCMPilot.Comm.Ivory.Types.GpsFix as GpsFix
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import Ivory.Language
import Ivory.Serialize
[ivory|
struct packed_status
  { valid :: (Stored IBool)
  ; roll :: (Stored IFloat)
  ; pitch :: (Stored IFloat)
  ; yaw :: (Stored IFloat)
  ; alt_est :: (Stored IFloat)
  ; fix :: (Stored GpsFix.GpsFix)
  ; num_sv :: (Stored Uint8)
  ; lat :: (Stored Sint32)
  ; lon :: (Stored Sint32)
  ; alt :: (Stored Sint32)
  ; vground :: (Stored Uint32)
  ; heading :: (Stored IFloat)
  ; rcinput :: (Stored Tristate.Tristate)
  ; telem :: (Stored Tristate.Tristate)
  ; px4io :: (Stored Tristate.Tristate)
  ; sens_valid :: (Stored Tristate.Tristate)
  ; arming_mode :: (Stored ArmingMode.ArmingMode)
  ; control_modes :: Struct control_modes
  ; battery_voltage :: (Stored IFloat)
  }
|]
packPackedStatus :: WrappedPackRep ('Struct "packed_status")
packPackedStatus = wrapPackRep "packed_status" $
  packStruct [ packLabel valid
             , packLabel roll
             , packLabel pitch
             , packLabel yaw
             , packLabel alt_est
             , packLabel fix
             , packLabel num_sv
             , packLabel lat
             , packLabel lon
             , packLabel alt
             , packLabel vground
             , packLabel heading
             , packLabel rcinput
             , packLabel telem
             , packLabel px4io
             , packLabel sens_valid
             , packLabel arming_mode
             , packLabel control_modes
             , packLabel battery_voltage
             ]
instance Packable ('Struct "packed_status") where
  packRep = wrappedPackRep packPackedStatus
packedStatusTypesModule :: Module
packedStatusTypesModule = package "packed_status_types" $ do
  defStruct (Proxy :: Proxy "packed_status")
  depend serializeModule
  wrappedPackMod packPackedStatus
  depend GpsFix.gpsFixTypesModule
  depend Tristate.tristateTypesModule
  depend ArmingMode.armingModeTypesModule
  depend ControlModes.controlModesTypesModule