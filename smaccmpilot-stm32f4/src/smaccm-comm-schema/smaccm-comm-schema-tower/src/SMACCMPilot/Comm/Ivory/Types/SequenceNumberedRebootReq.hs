{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRebootReq where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.RebootReq as RebootReq
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_reboot_req
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct reboot_req
  }
|]
packSequenceNumberedRebootReq :: WrappedPackRep ('Struct "sequence_numbered_reboot_req")
packSequenceNumberedRebootReq = wrapPackRep "sequence_numbered_reboot_req" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_reboot_req") where
  packRep = wrappedPackRep packSequenceNumberedRebootReq
sequenceNumberedRebootReqTypesModule :: Module
sequenceNumberedRebootReqTypesModule = package "sequence_numbered_reboot_req_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_reboot_req")
  depend serializeModule
  wrappedPackMod packSequenceNumberedRebootReq
  depend SequenceNum.sequenceNumTypesModule
  depend RebootReq.rebootReqTypesModule