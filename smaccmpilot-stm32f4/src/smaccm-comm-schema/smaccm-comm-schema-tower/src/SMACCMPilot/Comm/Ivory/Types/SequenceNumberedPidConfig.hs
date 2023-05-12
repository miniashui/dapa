{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPidConfig where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.PidConfig as PidConfig
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_pid_config
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct pid_config
  }
|]
packSequenceNumberedPidConfig :: WrappedPackRep ('Struct "sequence_numbered_pid_config")
packSequenceNumberedPidConfig = wrapPackRep "sequence_numbered_pid_config" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_pid_config") where
  packRep = wrappedPackRep packSequenceNumberedPidConfig
sequenceNumberedPidConfigTypesModule :: Module
sequenceNumberedPidConfigTypesModule = package "sequence_numbered_pid_config_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_pid_config")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPidConfig
  depend SequenceNum.sequenceNumTypesModule
  depend PidConfig.pidConfigTypesModule