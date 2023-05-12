{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowIntegralSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowIntegralSample as Px4flowIntegralSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_px4flow_integral_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct px4flow_integral_sample
  }
|]
packSequenceNumberedPx4flowIntegralSample :: WrappedPackRep ('Struct "sequence_numbered_px4flow_integral_sample")
packSequenceNumberedPx4flowIntegralSample = wrapPackRep "sequence_numbered_px4flow_integral_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_px4flow_integral_sample") where
  packRep = wrappedPackRep packSequenceNumberedPx4flowIntegralSample
sequenceNumberedPx4flowIntegralSampleTypesModule :: Module
sequenceNumberedPx4flowIntegralSampleTypesModule = package "sequence_numbered_px4flow_integral_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_px4flow_integral_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPx4flowIntegralSample
  depend SequenceNum.sequenceNumTypesModule
  depend Px4flowIntegralSample.px4flowIntegralSampleTypesModule