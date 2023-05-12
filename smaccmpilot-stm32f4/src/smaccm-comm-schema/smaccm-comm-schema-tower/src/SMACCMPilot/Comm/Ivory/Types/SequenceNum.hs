{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNum where
import Ivory.Language
import Ivory.Serialize
newtype SequenceNum =
  SequenceNum { unSequenceNum :: Uint32
              } deriving (IvoryType, IvoryVar, IvoryExpr, IvoryEq, IvoryStore, IvoryInit, IvoryZeroVal, Num)
packSequenceNum :: WrappedPackRep ('Stored SequenceNum)
packSequenceNum = wrapPackRep "sequence_num_t" $
  repackV SequenceNum unSequenceNum packRep
instance Packable ('Stored SequenceNum) where
  packRep = wrappedPackRep packSequenceNum
sequenceNumTypesModule :: Module
sequenceNumTypesModule = package "sequence_num_types" $ do
  depend serializeModule
  wrappedPackMod packSequenceNum