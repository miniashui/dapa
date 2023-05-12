{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedMagnetometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.MagnetometerSample as MagnetometerSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_magnetometer_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct magnetometer_sample
  }
|]
packSequenceNumberedMagnetometerSample :: WrappedPackRep ('Struct "sequence_numbered_magnetometer_sample")
packSequenceNumberedMagnetometerSample = wrapPackRep "sequence_numbered_magnetometer_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_magnetometer_sample") where
  packRep = wrappedPackRep packSequenceNumberedMagnetometerSample
sequenceNumberedMagnetometerSampleTypesModule :: Module
sequenceNumberedMagnetometerSampleTypesModule = package "sequence_numbered_magnetometer_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_magnetometer_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedMagnetometerSample
  depend SequenceNum.sequenceNumTypesModule
  depend MagnetometerSample.magnetometerSampleTypesModule