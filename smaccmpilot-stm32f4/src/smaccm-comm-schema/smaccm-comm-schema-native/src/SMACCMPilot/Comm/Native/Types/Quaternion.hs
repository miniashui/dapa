{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Quaternion where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Quaternion =
  Quaternion
    { quat_a :: Float
    , quat_b :: Float
    , quat_c :: Float
    , quat_d :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putQuaternion :: Putter Quaternion
putQuaternion Quaternion{..} = do
  putFloat32be quat_a
  putFloat32be quat_b
  putFloat32be quat_c
  putFloat32be quat_d
getQuaternion :: Get Quaternion
getQuaternion = do
  quat_a <- getFloat32be
  quat_b <- getFloat32be
  quat_c <- getFloat32be
  quat_d <- getFloat32be
  return Quaternion{..}
instance Serialize Quaternion where
  put = putQuaternion
  get = getQuaternion
arbitraryQuaternion :: Q.Gen Quaternion
arbitraryQuaternion = do
  quat_a <- Q.arbitrary
  quat_b <- Q.arbitrary
  quat_c <- Q.arbitrary
  quat_d <- Q.arbitrary
  return Quaternion{..}
instance Q.Arbitrary Quaternion where
  arbitrary = arbitraryQuaternion
instance ToJSON Quaternion
instance FromJSON Quaternion