{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedThrottleUi where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleUi as ThrottleUi
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_throttle_ui
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct throttle_ui
  }
|]
packSequenceNumberedThrottleUi :: WrappedPackRep ('Struct "sequence_numbered_throttle_ui")
packSequenceNumberedThrottleUi = wrapPackRep "sequence_numbered_throttle_ui" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_throttle_ui") where
  packRep = wrappedPackRep packSequenceNumberedThrottleUi
sequenceNumberedThrottleUiTypesModule :: Module
sequenceNumberedThrottleUiTypesModule = package "sequence_numbered_throttle_ui_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_throttle_ui")
  depend serializeModule
  wrappedPackMod packSequenceNumberedThrottleUi
  depend SequenceNum.sequenceNumTypesModule
  depend ThrottleUi.throttleUiTypesModule