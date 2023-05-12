{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedGyroscopeSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.GyroscopeSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedGyroscopeSample =
  SequenceNumberedGyroscopeSample
    { seqnum :: SequenceNum
    , val :: GyroscopeSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedGyroscopeSample :: Putter SequenceNumberedGyroscopeSample
putSequenceNumberedGyroscopeSample SequenceNumberedGyroscopeSample{..} = do
  putSequenceNum seqnum
  putGyroscopeSample val
getSequenceNumberedGyroscopeSample :: Get SequenceNumberedGyroscopeSample
getSequenceNumberedGyroscopeSample = do
  seqnum <- getSequenceNum
  val <- getGyroscopeSample
  return SequenceNumberedGyroscopeSample{..}
instance Serialize SequenceNumberedGyroscopeSample where
  put = putSequenceNumberedGyroscopeSample
  get = getSequenceNumberedGyroscopeSample
arbitrarySequenceNumberedGyroscopeSample :: Q.Gen SequenceNumberedGyroscopeSample
arbitrarySequenceNumberedGyroscopeSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedGyroscopeSample{..}
instance Q.Arbitrary SequenceNumberedGyroscopeSample where
  arbitrary = arbitrarySequenceNumberedGyroscopeSample
instance ToJSON SequenceNumberedGyroscopeSample
instance FromJSON SequenceNumberedGyroscopeSample