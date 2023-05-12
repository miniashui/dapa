{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.CameraTarget where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct camera_target
  { valid :: (Stored IBool)
  ; bbox_l :: (Stored Uint16)
  ; bbox_r :: (Stored Uint16)
  ; bbox_t :: (Stored Uint16)
  ; bbox_b :: (Stored Uint16)
  }
|]
packCameraTarget :: WrappedPackRep ('Struct "camera_target")
packCameraTarget = wrapPackRep "camera_target" $
  packStruct [ packLabel valid
             , packLabel bbox_l
             , packLabel bbox_r
             , packLabel bbox_t
             , packLabel bbox_b
             ]
instance Packable ('Struct "camera_target") where
  packRep = wrappedPackRep packCameraTarget
cameraTargetTypesModule :: Module
cameraTargetTypesModule = package "camera_target_types" $ do
  defStruct (Proxy :: Proxy "camera_target")
  depend serializeModule
  wrappedPackMod packCameraTarget