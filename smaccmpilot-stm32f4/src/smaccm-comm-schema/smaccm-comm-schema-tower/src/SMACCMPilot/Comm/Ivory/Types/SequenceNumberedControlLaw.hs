{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlLaw where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ControlLaw as ControlLaw
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_control_law
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct control_law
  }
|]
packSequenceNumberedControlLaw :: WrappedPackRep ('Struct "sequence_numbered_control_law")
packSequenceNumberedControlLaw = wrapPackRep "sequence_numbered_control_law" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_control_law") where
  packRep = wrappedPackRep packSequenceNumberedControlLaw
sequenceNumberedControlLawTypesModule :: Module
sequenceNumberedControlLawTypesModule = package "sequence_numbered_control_law_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_control_law")
  depend serializeModule
  wrappedPackMod packSequenceNumberedControlLaw
  depend SequenceNum.sequenceNumTypesModule
  depend ControlLaw.controlLawTypesModule