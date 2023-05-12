{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.StabConfig where
import qualified SMACCMPilot.Comm.Ivory.Types.PidConfig as PidConfig
import Ivory.Language
import Ivory.Serialize
[ivory|
struct stab_config
  { pos :: Struct pid_config
  ; rate :: Struct pid_config
  }
|]
packStabConfig :: WrappedPackRep ('Struct "stab_config")
packStabConfig = wrapPackRep "stab_config" $
  packStruct [ packLabel pos
             , packLabel rate
             ]
instance Packable ('Struct "stab_config") where
  packRep = wrappedPackRep packStabConfig
stabConfigTypesModule :: Module
stabConfigTypesModule = package "stab_config_types" $ do
  defStruct (Proxy :: Proxy "stab_config")
  depend serializeModule
  wrappedPackMod packStabConfig
  depend PidConfig.pidConfigTypesModule