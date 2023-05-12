{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedGyroscopeSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.GyroscopeSample as GyroscopeSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_gyroscope_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct gyroscope_sample
  }
|]
packSequenceNumberedGyroscopeSample :: WrappedPackRep ('Struct "sequence_numbered_gyroscope_sample")
packSequenceNumberedGyroscopeSample = wrapPackRep "sequence_numbered_gyroscope_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_gyroscope_sample") where
  packRep = wrappedPackRep packSequenceNumberedGyroscopeSample
sequenceNumberedGyroscopeSampleTypesModule :: Module
sequenceNumberedGyroscopeSampleTypesModule = package "sequence_numbered_gyroscope_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_gyroscope_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedGyroscopeSample
  depend SequenceNum.sequenceNumTypesModule
  depend GyroscopeSample.gyroscopeSampleTypesModule