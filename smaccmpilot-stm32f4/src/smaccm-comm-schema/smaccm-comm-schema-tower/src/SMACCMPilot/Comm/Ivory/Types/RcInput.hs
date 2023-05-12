{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.RcInput where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct rc_input
  { valid :: (Stored IBool)
  ; roll :: (Stored Uint16)
  ; pitch :: (Stored Uint16)
  ; throttle :: (Stored Uint16)
  ; yaw :: (Stored Uint16)
  ; switch1 :: (Stored Uint16)
  ; switch2 :: (Stored Uint16)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packRcInput :: WrappedPackRep ('Struct "rc_input")
packRcInput = wrapPackRep "rc_input" $
  packStruct [ packLabel valid
             , packLabel roll
             , packLabel pitch
             , packLabel throttle
             , packLabel yaw
             , packLabel switch1
             , packLabel switch2
             , packLabel time
             ]
instance Packable ('Struct "rc_input") where
  packRep = wrappedPackRep packRcInput
rcInputTypesModule :: Module
rcInputTypesModule = package "rc_input_types" $ do
  defStruct (Proxy :: Proxy "rc_input")
  depend serializeModule
  wrappedPackMod packRcInput
  depend TimeMicros.timeMicrosTypesModule