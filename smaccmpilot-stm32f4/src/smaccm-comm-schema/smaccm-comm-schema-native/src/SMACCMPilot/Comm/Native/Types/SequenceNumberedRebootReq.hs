{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedRebootReq where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.RebootReq
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedRebootReq =
  SequenceNumberedRebootReq
    { seqnum :: SequenceNum
    , val :: RebootReq
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedRebootReq :: Putter SequenceNumberedRebootReq
putSequenceNumberedRebootReq SequenceNumberedRebootReq{..} = do
  putSequenceNum seqnum
  putRebootReq val
getSequenceNumberedRebootReq :: Get SequenceNumberedRebootReq
getSequenceNumberedRebootReq = do
  seqnum <- getSequenceNum
  val <- getRebootReq
  return SequenceNumberedRebootReq{..}
instance Serialize SequenceNumberedRebootReq where
  put = putSequenceNumberedRebootReq
  get = getSequenceNumberedRebootReq
arbitrarySequenceNumberedRebootReq :: Q.Gen SequenceNumberedRebootReq
arbitrarySequenceNumberedRebootReq = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedRebootReq{..}
instance Q.Arbitrary SequenceNumberedRebootReq where
  arbitrary = arbitrarySequenceNumberedRebootReq
instance ToJSON SequenceNumberedRebootReq
instance FromJSON SequenceNumberedRebootReq