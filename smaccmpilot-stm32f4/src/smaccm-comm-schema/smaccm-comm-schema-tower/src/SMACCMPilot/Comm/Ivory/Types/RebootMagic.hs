{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.RebootMagic where
import Ivory.Language
import Ivory.Serialize
newtype RebootMagic =
  RebootMagic { unRebootMagic :: Uint32
              } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
linuxRebootMagic1 :: RebootMagic
linuxRebootMagic1 = RebootMagic 4276215469
packRebootMagic :: WrappedPackRep ('Stored RebootMagic)
packRebootMagic = wrapPackRep "reboot_magic_t" $
  repackV RebootMagic unRebootMagic packRep
instance Packable ('Stored RebootMagic) where
  packRep = wrappedPackRep packRebootMagic
rebootMagicTypesModule :: Module
rebootMagicTypesModule = package "reboot_magic_types" $ do
  depend serializeModule
  wrappedPackMod packRebootMagic