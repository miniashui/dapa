{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedArmingStatus where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ArmingStatus
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedArmingStatus =
  SequenceNumberedArmingStatus
    { seqnum :: SequenceNum
    , val :: ArmingStatus
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedArmingStatus :: Putter SequenceNumberedArmingStatus
putSequenceNumberedArmingStatus SequenceNumberedArmingStatus{..} = do
  putSequenceNum seqnum
  putArmingStatus val
getSequenceNumberedArmingStatus :: Get SequenceNumberedArmingStatus
getSequenceNumberedArmingStatus = do
  seqnum <- getSequenceNum
  val <- getArmingStatus
  return SequenceNumberedArmingStatus{..}
instance Serialize SequenceNumberedArmingStatus where
  put = putSequenceNumberedArmingStatus
  get = getSequenceNumberedArmingStatus
arbitrarySequenceNumberedArmingStatus :: Q.Gen SequenceNumberedArmingStatus
arbitrarySequenceNumberedArmingStatus = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedArmingStatus{..}
instance Q.Arbitrary SequenceNumberedArmingStatus where
  arbitrary = arbitrarySequenceNumberedArmingStatus
instance ToJSON SequenceNumberedArmingStatus
instance FromJSON SequenceNumberedArmingStatus