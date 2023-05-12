{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Tristate where
import Ivory.Language
import Ivory.Serialize
newtype Tristate =
  Tristate { unTristate :: Uint8
           } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal)
negative :: Tristate
negative = Tristate 0
neutral :: Tristate
neutral = Tristate 1
positive :: Tristate
positive = Tristate 2
packTristate :: WrappedPackRep ('Stored Tristate)
packTristate = wrapPackRep "tristate_t" $
  repackV Tristate unTristate packRep
instance Packable ('Stored Tristate) where
  packRep = wrappedPackRep packTristate
tristateTypesModule :: Module
tristateTypesModule = package "tristate_types" $ do
  depend serializeModule
  wrappedPackMod packTristate