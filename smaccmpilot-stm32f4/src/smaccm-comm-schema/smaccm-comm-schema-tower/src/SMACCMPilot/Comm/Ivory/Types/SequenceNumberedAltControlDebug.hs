{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAltControlDebug where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.AltControlDebug as AltControlDebug
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_alt_control_debug
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct alt_control_debug
  }
|]
packSequenceNumberedAltControlDebug :: WrappedPackRep ('Struct "sequence_numbered_alt_control_debug")
packSequenceNumberedAltControlDebug = wrapPackRep "sequence_numbered_alt_control_debug" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_alt_control_debug") where
  packRep = wrappedPackRep packSequenceNumberedAltControlDebug
sequenceNumberedAltControlDebugTypesModule :: Module
sequenceNumberedAltControlDebugTypesModule = package "sequence_numbered_alt_control_debug_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_alt_control_debug")
  depend serializeModule
  wrappedPackMod packSequenceNumberedAltControlDebug
  depend SequenceNum.sequenceNumTypesModule
  depend AltControlDebug.altControlDebugTypesModule