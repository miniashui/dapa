{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPackedStatus where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.PackedStatus as PackedStatus
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_packed_status
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct packed_status
  }
|]
packSequenceNumberedPackedStatus :: WrappedPackRep ('Struct "sequence_numbered_packed_status")
packSequenceNumberedPackedStatus = wrapPackRep "sequence_numbered_packed_status" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_packed_status") where
  packRep = wrappedPackRep packSequenceNumberedPackedStatus
sequenceNumberedPackedStatusTypesModule :: Module
sequenceNumberedPackedStatusTypesModule = package "sequence_numbered_packed_status_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_packed_status")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPackedStatus
  depend SequenceNum.sequenceNumTypesModule
  depend PackedStatus.packedStatusTypesModule