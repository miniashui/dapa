{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ControlModes where
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Ivory.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleMode as ThrottleMode
import Ivory.Language
import Ivory.Serialize
[ivory|
struct control_modes
  { ui_mode :: (Stored ControlSource.ControlSource)
  ; yaw_mode :: (Stored YawMode.YawMode)
  ; thr_mode :: (Stored ThrottleMode.ThrottleMode)
  }
|]
packControlModes :: WrappedPackRep ('Struct "control_modes")
packControlModes = wrapPackRep "control_modes" $
  packStruct [ packLabel ui_mode
             , packLabel yaw_mode
             , packLabel thr_mode
             ]
instance Packable ('Struct "control_modes") where
  packRep = wrappedPackRep packControlModes
controlModesTypesModule :: Module
controlModesTypesModule = package "control_modes_types" $ do
  defStruct (Proxy :: Proxy "control_modes")
  depend serializeModule
  wrappedPackMod packControlModes
  depend ControlSource.controlSourceTypesModule
  depend YawMode.yawModeTypesModule
  depend ThrottleMode.throttleModeTypesModule