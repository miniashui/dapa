{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.Px4flowSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPx4flowSample =
  SequenceNumberedPx4flowSample
    { seqnum :: SequenceNum
    , val :: Px4flowSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPx4flowSample :: Putter SequenceNumberedPx4flowSample
putSequenceNumberedPx4flowSample SequenceNumberedPx4flowSample{..} = do
  putSequenceNum seqnum
  putPx4flowSample val
getSequenceNumberedPx4flowSample :: Get SequenceNumberedPx4flowSample
getSequenceNumberedPx4flowSample = do
  seqnum <- getSequenceNum
  val <- getPx4flowSample
  return SequenceNumberedPx4flowSample{..}
instance Serialize SequenceNumberedPx4flowSample where
  put = putSequenceNumberedPx4flowSample
  get = getSequenceNumberedPx4flowSample
arbitrarySequenceNumberedPx4flowSample :: Q.Gen SequenceNumberedPx4flowSample
arbitrarySequenceNumberedPx4flowSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPx4flowSample{..}
instance Q.Arbitrary SequenceNumberedPx4flowSample where
  arbitrary = arbitrarySequenceNumberedPx4flowSample
instance ToJSON SequenceNumberedPx4flowSample
instance FromJSON SequenceNumberedPx4flowSample