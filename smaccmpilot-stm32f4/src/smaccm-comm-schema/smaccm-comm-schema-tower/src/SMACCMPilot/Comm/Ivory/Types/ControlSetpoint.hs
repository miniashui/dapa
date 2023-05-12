{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ControlSetpoint where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct control_setpoint
  { altitude :: (Stored IFloat)
  ; alt_rate :: (Stored IFloat)
  ; roll :: (Stored IFloat)
  ; pitch :: (Stored IFloat)
  ; heading :: (Stored IFloat)
  }
|]
packControlSetpoint :: WrappedPackRep ('Struct "control_setpoint")
packControlSetpoint = wrapPackRep "control_setpoint" $
  packStruct [ packLabel altitude
             , packLabel alt_rate
             , packLabel roll
             , packLabel pitch
             , packLabel heading
             ]
instance Packable ('Struct "control_setpoint") where
  packRep = wrappedPackRep packControlSetpoint
controlSetpointTypesModule :: Module
controlSetpointTypesModule = package "control_setpoint_types" $ do
  defStruct (Proxy :: Proxy "control_setpoint")
  depend serializeModule
  wrappedPackMod packControlSetpoint