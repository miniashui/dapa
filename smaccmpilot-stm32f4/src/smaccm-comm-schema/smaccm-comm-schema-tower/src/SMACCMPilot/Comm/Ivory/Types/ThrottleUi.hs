{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ThrottleUi where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct throttle_ui
  { sens :: (Stored IFloat)
  ; dead :: (Stored IFloat)
  }
|]
packThrottleUi :: WrappedPackRep ('Struct "throttle_ui")
packThrottleUi = wrapPackRep "throttle_ui" $
  packStruct [ packLabel sens
             , packLabel dead
             ]
instance Packable ('Struct "throttle_ui") where
  packRep = wrappedPackRep packThrottleUi
throttleUiTypesModule :: Module
throttleUiTypesModule = package "throttle_ui_types" $ do
  defStruct (Proxy :: Proxy "throttle_ui")
  depend serializeModule
  wrappedPackMod packThrottleUi