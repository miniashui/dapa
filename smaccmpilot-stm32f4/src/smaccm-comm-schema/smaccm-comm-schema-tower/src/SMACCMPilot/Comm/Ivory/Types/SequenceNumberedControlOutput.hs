{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlOutput where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ControlOutput as ControlOutput
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_control_output
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct control_output
  }
|]
packSequenceNumberedControlOutput :: WrappedPackRep ('Struct "sequence_numbered_control_output")
packSequenceNumberedControlOutput = wrapPackRep "sequence_numbered_control_output" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_control_output") where
  packRep = wrappedPackRep packSequenceNumberedControlOutput
sequenceNumberedControlOutputTypesModule :: Module
sequenceNumberedControlOutputTypesModule = package "sequence_numbered_control_output_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_control_output")
  depend serializeModule
  wrappedPackMod packSequenceNumberedControlOutput
  depend SequenceNum.sequenceNumTypesModule
  depend ControlOutput.controlOutputTypesModule