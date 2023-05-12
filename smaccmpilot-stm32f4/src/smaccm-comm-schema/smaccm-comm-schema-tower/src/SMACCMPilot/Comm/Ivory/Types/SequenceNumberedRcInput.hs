{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRcInput where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.RcInput as RcInput
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_rc_input
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct rc_input
  }
|]
packSequenceNumberedRcInput :: WrappedPackRep ('Struct "sequence_numbered_rc_input")
packSequenceNumberedRcInput = wrapPackRep "sequence_numbered_rc_input" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_rc_input") where
  packRep = wrappedPackRep packSequenceNumberedRcInput
sequenceNumberedRcInputTypesModule :: Module
sequenceNumberedRcInputTypesModule = package "sequence_numbered_rc_input_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_rc_input")
  depend serializeModule
  wrappedPackMod packSequenceNumberedRcInput
  depend SequenceNum.sequenceNumTypesModule
  depend RcInput.rcInputTypesModule