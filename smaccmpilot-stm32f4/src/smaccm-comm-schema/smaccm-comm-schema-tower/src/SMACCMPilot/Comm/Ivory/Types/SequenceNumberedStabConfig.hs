{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedStabConfig where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.StabConfig as StabConfig
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_stab_config
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct stab_config
  }
|]
packSequenceNumberedStabConfig :: WrappedPackRep ('Struct "sequence_numbered_stab_config")
packSequenceNumberedStabConfig = wrapPackRep "sequence_numbered_stab_config" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_stab_config") where
  packRep = wrappedPackRep packSequenceNumberedStabConfig
sequenceNumberedStabConfigTypesModule :: Module
sequenceNumberedStabConfigTypesModule = package "sequence_numbered_stab_config_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_stab_config")
  depend serializeModule
  wrappedPackMod packSequenceNumberedStabConfig
  depend SequenceNum.sequenceNumTypesModule
  depend StabConfig.stabConfigTypesModule