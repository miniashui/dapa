{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.TimeMicros where
import Ivory.Language
import Ivory.Serialize
newtype TimeMicros =
  TimeMicros { unTimeMicros :: Sint64
             } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal, Num)
packTimeMicros :: WrappedPackRep ('Stored TimeMicros)
packTimeMicros = wrapPackRep "time_micros_t" $
  repackV TimeMicros unTimeMicros packRep
instance Packable ('Stored TimeMicros) where
  packRep = wrappedPackRep packTimeMicros
timeMicrosTypesModule :: Module
timeMicrosTypesModule = package "time_micros_types" $ do
  depend serializeModule
  wrappedPackMod packTimeMicros