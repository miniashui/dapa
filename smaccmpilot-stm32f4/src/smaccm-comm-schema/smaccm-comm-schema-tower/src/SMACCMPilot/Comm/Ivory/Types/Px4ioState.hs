{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Px4ioState where
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioStatus as Px4ioStatus
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioAlarms as Px4ioAlarms
import qualified SMACCMPilot.Comm.Ivory.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct px4io_state
  { comm_ok :: (Stored IBool)
  ; status :: Struct px4io_status
  ; alarms :: Struct px4io_alarms
  ; rc_in :: Struct rc_input
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packPx4ioState :: WrappedPackRep ('Struct "px4io_state")
packPx4ioState = wrapPackRep "px4io_state" $
  packStruct [ packLabel comm_ok
             , packLabel status
             , packLabel alarms
             , packLabel rc_in
             , packLabel time
             ]
instance Packable ('Struct "px4io_state") where
  packRep = wrappedPackRep packPx4ioState
px4ioStateTypesModule :: Module
px4ioStateTypesModule = package "px4io_state_types" $ do
  defStruct (Proxy :: Proxy "px4io_state")
  depend serializeModule
  wrappedPackMod packPx4ioState
  depend Px4ioStatus.px4ioStatusTypesModule
  depend Px4ioAlarms.px4ioAlarmsTypesModule
  depend RcInput.rcInputTypesModule
  depend TimeMicros.timeMicrosTypesModule