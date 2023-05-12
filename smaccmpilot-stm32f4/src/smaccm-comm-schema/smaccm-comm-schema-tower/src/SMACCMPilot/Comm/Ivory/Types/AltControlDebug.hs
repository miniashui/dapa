{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.AltControlDebug where
import qualified SMACCMPilot.Comm.Ivory.Types.PidState as PidState
import Ivory.Language
import Ivory.Serialize
[ivory|
struct alt_control_debug
  { alt_est :: (Stored IFloat)
  ; alt_rate_est :: (Stored IFloat)
  ; r22_gain :: (Stored IFloat)
  ; ui_setp :: (Stored IFloat)
  ; ui_rate_setp :: (Stored IFloat)
  ; pos :: Struct pid_state
  ; vz_fb :: (Stored IFloat)
  ; vz_ff :: (Stored IFloat)
  ; vz_ff_rot :: (Stored IFloat)
  ; vz_ctl :: (Stored IFloat)
  }
|]
packAltControlDebug :: WrappedPackRep ('Struct "alt_control_debug")
packAltControlDebug = wrapPackRep "alt_control_debug" $
  packStruct [ packLabel alt_est
             , packLabel alt_rate_est
             , packLabel r22_gain
             , packLabel ui_setp
             , packLabel ui_rate_setp
             , packLabel pos
             , packLabel vz_fb
             , packLabel vz_ff
             , packLabel vz_ff_rot
             , packLabel vz_ctl
             ]
instance Packable ('Struct "alt_control_debug") where
  packRep = wrappedPackRep packAltControlDebug
altControlDebugTypesModule :: Module
altControlDebugTypesModule = package "alt_control_debug_types" $ do
  defStruct (Proxy :: Proxy "alt_control_debug")
  depend serializeModule
  wrappedPackMod packAltControlDebug
  depend PidState.pidStateTypesModule