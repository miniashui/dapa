{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedRcInput where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.RcInput
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedRcInput =
  SequenceNumberedRcInput
    { seqnum :: SequenceNum
    , val :: RcInput
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedRcInput :: Putter SequenceNumberedRcInput
putSequenceNumberedRcInput SequenceNumberedRcInput{..} = do
  putSequenceNum seqnum
  putRcInput val
getSequenceNumberedRcInput :: Get SequenceNumberedRcInput
getSequenceNumberedRcInput = do
  seqnum <- getSequenceNum
  val <- getRcInput
  return SequenceNumberedRcInput{..}
instance Serialize SequenceNumberedRcInput where
  put = putSequenceNumberedRcInput
  get = getSequenceNumberedRcInput
arbitrarySequenceNumberedRcInput :: Q.Gen SequenceNumberedRcInput
arbitrarySequenceNumberedRcInput = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedRcInput{..}
instance Q.Arbitrary SequenceNumberedRcInput where
  arbitrary = arbitrarySequenceNumberedRcInput
instance ToJSON SequenceNumberedRcInput
instance FromJSON SequenceNumberedRcInput