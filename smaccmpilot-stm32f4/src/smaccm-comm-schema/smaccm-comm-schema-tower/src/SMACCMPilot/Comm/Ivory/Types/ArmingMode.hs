{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ArmingMode where
import Ivory.Language
import Ivory.Serialize
newtype ArmingMode =
  ArmingMode { unArmingMode :: Uint8
             } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
safe :: ArmingMode
safe = ArmingMode 0
armed :: ArmingMode
armed = ArmingMode 1
packArmingMode :: WrappedPackRep ('Stored ArmingMode)
packArmingMode = wrapPackRep "arming_mode_t" $
  repackV ArmingMode unArmingMode packRep
instance Packable ('Stored ArmingMode) where
  packRep = wrappedPackRep packArmingMode
armingModeTypesModule :: Module
armingModeTypesModule = package "arming_mode_types" $ do
  depend serializeModule
  wrappedPackMod packArmingMode