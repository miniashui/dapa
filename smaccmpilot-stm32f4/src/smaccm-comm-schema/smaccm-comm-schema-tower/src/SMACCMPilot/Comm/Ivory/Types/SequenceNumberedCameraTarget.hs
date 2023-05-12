{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedCameraTarget where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.CameraTarget as CameraTarget
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_camera_target
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct camera_target
  }
|]
packSequenceNumberedCameraTarget :: WrappedPackRep ('Struct "sequence_numbered_camera_target")
packSequenceNumberedCameraTarget = wrapPackRep "sequence_numbered_camera_target" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_camera_target") where
  packRep = wrappedPackRep packSequenceNumberedCameraTarget
sequenceNumberedCameraTargetTypesModule :: Module
sequenceNumberedCameraTargetTypesModule = package "sequence_numbered_camera_target_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_camera_target")
  depend serializeModule
  wrappedPackMod packSequenceNumberedCameraTarget
  depend SequenceNum.sequenceNumTypesModule
  depend CameraTarget.cameraTargetTypesModule