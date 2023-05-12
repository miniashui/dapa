{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.AttControlDebug where
import qualified SMACCMPilot.Comm.Ivory.Types.PidState as PidState
import Ivory.Language
import Ivory.Serialize
[ivory|
struct att_control_debug
  { head_setpt :: (Stored IFloat)
  ; head_rate_est :: (Stored IFloat)
  ; head_rate_setpt :: (Stored IFloat)
  ; head_ctl_p :: (Stored IFloat)
  ; head_ctl_d :: (Stored IFloat)
  ; pitch_setpt :: (Stored IFloat)
  ; pitch_rate_setpt :: (Stored IFloat)
  ; roll_setpt :: (Stored IFloat)
  ; roll_rate_setpt :: (Stored IFloat)
  ; att_pid :: Struct pid_state
  }
|]
packAttControlDebug :: WrappedPackRep ('Struct "att_control_debug")
packAttControlDebug = wrapPackRep "att_control_debug" $
  packStruct [ packLabel head_setpt
             , packLabel head_rate_est
             , packLabel head_rate_setpt
             , packLabel head_ctl_p
             , packLabel head_ctl_d
             , packLabel pitch_setpt
             , packLabel pitch_rate_setpt
             , packLabel roll_setpt
             , packLabel roll_rate_setpt
             , packLabel att_pid
             ]
instance Packable ('Struct "att_control_debug") where
  packRep = wrappedPackRep packAttControlDebug
attControlDebugTypesModule :: Module
attControlDebugTypesModule = package "att_control_debug_types" $ do
  defStruct (Proxy :: Proxy "att_control_debug")
  depend serializeModule
  wrappedPackMod packAttControlDebug
  depend PidState.pidStateTypesModule