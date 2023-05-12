{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ThrottleMode where
import Ivory.Language
import Ivory.Serialize
newtype ThrottleMode =
  ThrottleMode { unThrottleMode :: Uint8
               } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
directUi :: ThrottleMode
directUi = ThrottleMode 0
altUi :: ThrottleMode
altUi = ThrottleMode 1
altSetpt :: ThrottleMode
altSetpt = ThrottleMode 2
packThrottleMode :: WrappedPackRep ('Stored ThrottleMode)
packThrottleMode = wrapPackRep "throttle_mode_t" $
  repackV ThrottleMode unThrottleMode packRep
instance Packable ('Stored ThrottleMode) where
  packRep = wrappedPackRep packThrottleMode
throttleModeTypesModule :: Module
throttleModeTypesModule = package "throttle_mode_types" $ do
  depend serializeModule
  wrappedPackMod packThrottleMode