{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ControlOutput where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct control_output
  { armed :: (Stored IBool)
  ; throttle :: (Stored IFloat)
  ; roll :: (Stored IFloat)
  ; pitch :: (Stored IFloat)
  ; yaw :: (Stored IFloat)
  }
|]
packControlOutput :: WrappedPackRep ('Struct "control_output")
packControlOutput = wrapPackRep "control_output" $
  packStruct [ packLabel armed
             , packLabel throttle
             , packLabel roll
             , packLabel pitch
             , packLabel yaw
             ]
instance Packable ('Struct "control_output") where
  packRep = wrappedPackRep packControlOutput
controlOutputTypesModule :: Module
controlOutputTypesModule = package "control_output_types" $ do
  defStruct (Proxy :: Proxy "control_output")
  depend serializeModule
  wrappedPackMod packControlOutput