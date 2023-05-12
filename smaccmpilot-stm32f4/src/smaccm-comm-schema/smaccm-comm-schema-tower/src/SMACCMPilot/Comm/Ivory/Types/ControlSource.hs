{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ControlSource where
import Ivory.Language
import Ivory.Serialize
newtype ControlSource =
  ControlSource { unControlSource :: Uint8
                } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
ppm :: ControlSource
ppm = ControlSource 0
gcs :: ControlSource
gcs = ControlSource 1
nav :: ControlSource
nav = ControlSource 2
packControlSource :: WrappedPackRep ('Stored ControlSource)
packControlSource = wrapPackRep "control_source_t" $
  repackV ControlSource unControlSource packRep
instance Packable ('Stored ControlSource) where
  packRep = wrappedPackRep packControlSource
controlSourceTypesModule :: Module
controlSourceTypesModule = package "control_source_types" $ do
  depend serializeModule
  wrappedPackMod packControlSource