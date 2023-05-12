{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Quaternion where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct quaternion
  { quat_a :: (Stored IFloat)
  ; quat_b :: (Stored IFloat)
  ; quat_c :: (Stored IFloat)
  ; quat_d :: (Stored IFloat)
  }
|]
packQuaternion :: WrappedPackRep ('Struct "quaternion")
packQuaternion = wrapPackRep "quaternion" $
  packStruct [ packLabel quat_a
             , packLabel quat_b
             , packLabel quat_c
             , packLabel quat_d
             ]
instance Packable ('Struct "quaternion") where
  packRep = wrappedPackRep packQuaternion
quaternionTypesModule :: Module
quaternionTypesModule = package "quaternion_types" $ do
  defStruct (Proxy :: Proxy "quaternion")
  depend serializeModule
  wrappedPackMod packQuaternion