{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.PidConfig where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct pid_config
  { p_gain :: (Stored IFloat)
  ; i_gain :: (Stored IFloat)
  ; d_gain :: (Stored IFloat)
  ; dd_gain :: (Stored IFloat)
  ; i_min :: (Stored IFloat)
  ; i_max :: (Stored IFloat)
  ; err_max :: (Stored IFloat)
  ; errd_max :: (Stored IFloat)
  }
|]
packPidConfig :: WrappedPackRep ('Struct "pid_config")
packPidConfig = wrapPackRep "pid_config" $
  packStruct [ packLabel p_gain
             , packLabel i_gain
             , packLabel d_gain
             , packLabel dd_gain
             , packLabel i_min
             , packLabel i_max
             , packLabel err_max
             , packLabel errd_max
             ]
instance Packable ('Struct "pid_config") where
  packRep = wrappedPackRep packPidConfig
pidConfigTypesModule :: Module
pidConfigTypesModule = package "pid_config_types" $ do
  defStruct (Proxy :: Proxy "pid_config")
  depend serializeModule
  wrappedPackMod packPidConfig