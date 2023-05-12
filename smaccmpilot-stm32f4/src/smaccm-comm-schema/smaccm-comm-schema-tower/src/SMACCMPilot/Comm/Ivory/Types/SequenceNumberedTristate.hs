{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedTristate where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_tristate
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: (Stored Tristate.Tristate)
  }
|]
packSequenceNumberedTristate :: WrappedPackRep ('Struct "sequence_numbered_tristate")
packSequenceNumberedTristate = wrapPackRep "sequence_numbered_tristate" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_tristate") where
  packRep = wrappedPackRep packSequenceNumberedTristate
sequenceNumberedTristateTypesModule :: Module
sequenceNumberedTristateTypesModule = package "sequence_numbered_tristate_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_tristate")
  depend serializeModule
  wrappedPackMod packSequenceNumberedTristate
  depend SequenceNum.sequenceNumTypesModule
  depend Tristate.tristateTypesModule