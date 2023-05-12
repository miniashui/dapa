{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowSample as Px4flowSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_px4flow_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct px4flow_sample
  }
|]
packSequenceNumberedPx4flowSample :: WrappedPackRep ('Struct "sequence_numbered_px4flow_sample")
packSequenceNumberedPx4flowSample = wrapPackRep "sequence_numbered_px4flow_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_px4flow_sample") where
  packRep = wrappedPackRep packSequenceNumberedPx4flowSample
sequenceNumberedPx4flowSampleTypesModule :: Module
sequenceNumberedPx4flowSampleTypesModule = package "sequence_numbered_px4flow_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_px4flow_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPx4flowSample
  depend SequenceNum.sequenceNumTypesModule
  depend Px4flowSample.px4flowSampleTypesModule