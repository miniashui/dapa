{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.CameraTarget where
import Data.Word
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data CameraTarget =
  CameraTarget
    { valid :: Bool
    , bbox_l :: Word16
    , bbox_r :: Word16
    , bbox_t :: Word16
    , bbox_b :: Word16
    } deriving (Eq, Show, Data, Typeable, Generic)
putCameraTarget :: Putter CameraTarget
putCameraTarget CameraTarget{..} = do
  put valid
  putWord16be bbox_l
  putWord16be bbox_r
  putWord16be bbox_t
  putWord16be bbox_b
getCameraTarget :: Get CameraTarget
getCameraTarget = do
  valid <- get
  bbox_l <- getWord16be
  bbox_r <- getWord16be
  bbox_t <- getWord16be
  bbox_b <- getWord16be
  return CameraTarget{..}
instance Serialize CameraTarget where
  put = putCameraTarget
  get = getCameraTarget
arbitraryCameraTarget :: Q.Gen CameraTarget
arbitraryCameraTarget = do
  valid <- Q.arbitrary
  bbox_l <- Q.arbitrary
  bbox_r <- Q.arbitrary
  bbox_t <- Q.arbitrary
  bbox_b <- Q.arbitrary
  return CameraTarget{..}
instance Q.Arbitrary CameraTarget where
  arbitrary = arbitraryCameraTarget
instance ToJSON CameraTarget
instance FromJSON CameraTarget