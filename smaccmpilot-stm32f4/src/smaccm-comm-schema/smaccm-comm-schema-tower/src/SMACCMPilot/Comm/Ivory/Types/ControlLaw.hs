{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ControlLaw where
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import Ivory.Language
import Ivory.Serialize
[ivory|
struct control_law
  { arming_mode :: (Stored ArmingMode.ArmingMode)
  ; control_modes :: Struct control_modes
  }
|]
packControlLaw :: WrappedPackRep ('Struct "control_law")
packControlLaw = wrapPackRep "control_law" $
  packStruct [ packLabel arming_mode
             , packLabel control_modes
             ]
instance Packable ('Struct "control_law") where
  packRep = wrappedPackRep packControlLaw
controlLawTypesModule :: Module
controlLawTypesModule = package "control_law_types" $ do
  defStruct (Proxy :: Proxy "control_law")
  depend serializeModule
  wrappedPackMod packControlLaw
  depend ArmingMode.armingModeTypesModule
  depend ControlModes.controlModesTypesModule