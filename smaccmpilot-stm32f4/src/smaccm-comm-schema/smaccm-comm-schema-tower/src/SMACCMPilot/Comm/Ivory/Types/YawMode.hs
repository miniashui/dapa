{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.YawMode where
import Ivory.Language
import Ivory.Serialize
newtype YawMode =
  YawMode { unYawMode :: Uint8
          } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
rate :: YawMode
rate = YawMode 0
heading :: YawMode
heading = YawMode 1
packYawMode :: WrappedPackRep ('Stored YawMode)
packYawMode = wrapPackRep "yaw_mode_t" $
  repackV YawMode unYawMode packRep
instance Packable ('Stored YawMode) where
  packRep = wrappedPackRep packYawMode
yawModeTypesModule :: Module
yawModeTypesModule = package "yaw_mode_types" $ do
  depend serializeModule
  wrappedPackMod packYawMode