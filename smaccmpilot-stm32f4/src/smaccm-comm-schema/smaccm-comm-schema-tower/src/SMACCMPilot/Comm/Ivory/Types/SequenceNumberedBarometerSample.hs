{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedBarometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.BarometerSample as BarometerSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_barometer_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct barometer_sample
  }
|]
packSequenceNumberedBarometerSample :: WrappedPackRep ('Struct "sequence_numbered_barometer_sample")
packSequenceNumberedBarometerSample = wrapPackRep "sequence_numbered_barometer_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_barometer_sample") where
  packRep = wrappedPackRep packSequenceNumberedBarometerSample
sequenceNumberedBarometerSampleTypesModule :: Module
sequenceNumberedBarometerSampleTypesModule = package "sequence_numbered_barometer_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_barometer_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedBarometerSample
  depend SequenceNum.sequenceNumTypesModule
  depend BarometerSample.barometerSampleTypesModule