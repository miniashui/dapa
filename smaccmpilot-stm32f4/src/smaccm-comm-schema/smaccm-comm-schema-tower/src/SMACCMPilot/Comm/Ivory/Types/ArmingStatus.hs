{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.ArmingStatus where
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import Ivory.Language
import Ivory.Serialize
[ivory|
struct arming_status
  { rcinput :: (Stored Tristate.Tristate)
  ; telem :: (Stored Tristate.Tristate)
  ; px4io :: (Stored Tristate.Tristate)
  ; sens_valid :: (Stored Tristate.Tristate)
  }
|]
packArmingStatus :: WrappedPackRep ('Struct "arming_status")
packArmingStatus = wrapPackRep "arming_status" $
  packStruct [ packLabel rcinput
             , packLabel telem
             , packLabel px4io
             , packLabel sens_valid
             ]
instance Packable ('Struct "arming_status") where
  packRep = wrappedPackRep packArmingStatus
armingStatusTypesModule :: Module
armingStatusTypesModule = package "arming_status_types" $ do
  defStruct (Proxy :: Proxy "arming_status")
  depend serializeModule
  wrappedPackMod packArmingStatus
  depend Tristate.tristateTypesModule