{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPackedStatus where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.PackedStatus
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPackedStatus =
  SequenceNumberedPackedStatus
    { seqnum :: SequenceNum
    , val :: PackedStatus
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPackedStatus :: Putter SequenceNumberedPackedStatus
putSequenceNumberedPackedStatus SequenceNumberedPackedStatus{..} = do
  putSequenceNum seqnum
  putPackedStatus val
getSequenceNumberedPackedStatus :: Get SequenceNumberedPackedStatus
getSequenceNumberedPackedStatus = do
  seqnum <- getSequenceNum
  val <- getPackedStatus
  return SequenceNumberedPackedStatus{..}
instance Serialize SequenceNumberedPackedStatus where
  put = putSequenceNumberedPackedStatus
  get = getSequenceNumberedPackedStatus
arbitrarySequenceNumberedPackedStatus :: Q.Gen SequenceNumberedPackedStatus
arbitrarySequenceNumberedPackedStatus = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPackedStatus{..}
instance Q.Arbitrary SequenceNumberedPackedStatus where
  arbitrary = arbitrarySequenceNumberedPackedStatus
instance ToJSON SequenceNumberedPackedStatus
instance FromJSON SequenceNumberedPackedStatus