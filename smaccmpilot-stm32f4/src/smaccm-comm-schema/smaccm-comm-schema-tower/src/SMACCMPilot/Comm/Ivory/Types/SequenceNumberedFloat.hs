{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedFloat where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_float
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: (Stored IFloat)
  }
|]
packSequenceNumberedFloat :: WrappedPackRep ('Struct "sequence_numbered_float")
packSequenceNumberedFloat = wrapPackRep "sequence_numbered_float" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_float") where
  packRep = wrappedPackRep packSequenceNumberedFloat
sequenceNumberedFloatTypesModule :: Module
sequenceNumberedFloatTypesModule = package "sequence_numbered_float_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_float")
  depend serializeModule
  wrappedPackMod packSequenceNumberedFloat
  depend SequenceNum.sequenceNumTypesModule