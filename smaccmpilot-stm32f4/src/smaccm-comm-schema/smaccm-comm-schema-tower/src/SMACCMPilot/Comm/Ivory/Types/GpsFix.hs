{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.GpsFix where
import Ivory.Language
import Ivory.Serialize
newtype GpsFix =
  GpsFix { unGpsFix :: Uint8
         } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
fixNone :: GpsFix
fixNone = GpsFix 0
fix2d :: GpsFix
fix2d = GpsFix 2
fix3d :: GpsFix
fix3d = GpsFix 3
packGpsFix :: WrappedPackRep ('Stored GpsFix)
packGpsFix = wrapPackRep "gps_fix_t" $
  repackV GpsFix unGpsFix packRep
instance Packable ('Stored GpsFix) where
  packRep = wrappedPackRep packGpsFix
gpsFixTypesModule :: Module
gpsFixTypesModule = package "gps_fix_types" $ do
  depend serializeModule
  wrappedPackMod packGpsFix