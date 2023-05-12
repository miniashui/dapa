{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedArmingStatus where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingStatus as ArmingStatus
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_arming_status
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct arming_status
  }
|]
packSequenceNumberedArmingStatus :: WrappedPackRep ('Struct "sequence_numbered_arming_status")
packSequenceNumberedArmingStatus = wrapPackRep "sequence_numbered_arming_status" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_arming_status") where
  packRep = wrappedPackRep packSequenceNumberedArmingStatus
sequenceNumberedArmingStatusTypesModule :: Module
sequenceNumberedArmingStatusTypesModule = package "sequence_numbered_arming_status_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_arming_status")
  depend serializeModule
  wrappedPackMod packSequenceNumberedArmingStatus
  depend SequenceNum.sequenceNumTypesModule
  depend ArmingStatus.armingStatusTypesModule