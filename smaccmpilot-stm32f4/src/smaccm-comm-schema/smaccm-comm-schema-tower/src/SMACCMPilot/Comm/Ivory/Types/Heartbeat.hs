{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Heartbeat where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import Ivory.Language
import Ivory.Serialize
[ivory|
struct heartbeat
  { time :: (Stored TimeMicros.TimeMicros)
  ; arming_mode :: (Stored ArmingMode.ArmingMode)
  }
|]
packHeartbeat :: WrappedPackRep ('Struct "heartbeat")
packHeartbeat = wrapPackRep "heartbeat" $
  packStruct [ packLabel time
             , packLabel arming_mode
             ]
instance Packable ('Struct "heartbeat") where
  packRep = wrappedPackRep packHeartbeat
heartbeatTypesModule :: Module
heartbeatTypesModule = package "heartbeat_types" $ do
  defStruct (Proxy :: Proxy "heartbeat")
  depend serializeModule
  wrappedPackMod packHeartbeat
  depend TimeMicros.timeMicrosTypesModule
  depend ArmingMode.armingModeTypesModule