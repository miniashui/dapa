{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAccelerometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.AccelerometerSample as AccelerometerSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_accelerometer_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct accelerometer_sample
  }
|]
packSequenceNumberedAccelerometerSample :: WrappedPackRep ('Struct "sequence_numbered_accelerometer_sample")
packSequenceNumberedAccelerometerSample = wrapPackRep "sequence_numbered_accelerometer_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_accelerometer_sample") where
  packRep = wrappedPackRep packSequenceNumberedAccelerometerSample
sequenceNumberedAccelerometerSampleTypesModule :: Module
sequenceNumberedAccelerometerSampleTypesModule = package "sequence_numbered_accelerometer_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_accelerometer_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedAccelerometerSample
  depend SequenceNum.sequenceNumTypesModule
  depend AccelerometerSample.accelerometerSampleTypesModule