{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedLidarliteSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.LidarliteSample as LidarliteSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_lidarlite_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct lidarlite_sample
  }
|]
packSequenceNumberedLidarliteSample :: WrappedPackRep ('Struct "sequence_numbered_lidarlite_sample")
packSequenceNumberedLidarliteSample = wrapPackRep "sequence_numbered_lidarlite_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_lidarlite_sample") where
  packRep = wrappedPackRep packSequenceNumberedLidarliteSample
sequenceNumberedLidarliteSampleTypesModule :: Module
sequenceNumberedLidarliteSampleTypesModule = package "sequence_numbered_lidarlite_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_lidarlite_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedLidarliteSample
  depend SequenceNum.sequenceNumTypesModule
  depend LidarliteSample.lidarliteSampleTypesModule