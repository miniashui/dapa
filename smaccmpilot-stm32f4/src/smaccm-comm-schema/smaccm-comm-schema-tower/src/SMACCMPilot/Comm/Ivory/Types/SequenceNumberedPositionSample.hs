{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPositionSample where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.PositionSample as PositionSample
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_position_sample
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct position_sample
  }
|]
packSequenceNumberedPositionSample :: WrappedPackRep ('Struct "sequence_numbered_position_sample")
packSequenceNumberedPositionSample = wrapPackRep "sequence_numbered_position_sample" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_position_sample") where
  packRep = wrappedPackRep packSequenceNumberedPositionSample
sequenceNumberedPositionSampleTypesModule :: Module
sequenceNumberedPositionSampleTypesModule = package "sequence_numbered_position_sample_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_position_sample")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPositionSample
  depend SequenceNum.sequenceNumTypesModule
  depend PositionSample.positionSampleTypesModule