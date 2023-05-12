{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedCameraTarget where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.CameraTarget
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedCameraTarget =
  SequenceNumberedCameraTarget
    { seqnum :: SequenceNum
    , val :: CameraTarget
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedCameraTarget :: Putter SequenceNumberedCameraTarget
putSequenceNumberedCameraTarget SequenceNumberedCameraTarget{..} = do
  putSequenceNum seqnum
  putCameraTarget val
getSequenceNumberedCameraTarget :: Get SequenceNumberedCameraTarget
getSequenceNumberedCameraTarget = do
  seqnum <- getSequenceNum
  val <- getCameraTarget
  return SequenceNumberedCameraTarget{..}
instance Serialize SequenceNumberedCameraTarget where
  put = putSequenceNumberedCameraTarget
  get = getSequenceNumberedCameraTarget
arbitrarySequenceNumberedCameraTarget :: Q.Gen SequenceNumberedCameraTarget
arbitrarySequenceNumberedCameraTarget = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedCameraTarget{..}
instance Q.Arbitrary SequenceNumberedCameraTarget where
  arbitrary = arbitrarySequenceNumberedCameraTarget
instance ToJSON SequenceNumberedCameraTarget
instance FromJSON SequenceNumberedCameraTarget