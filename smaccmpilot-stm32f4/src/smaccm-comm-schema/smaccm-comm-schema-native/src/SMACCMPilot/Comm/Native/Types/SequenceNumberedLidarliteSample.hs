{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedLidarliteSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.LidarliteSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedLidarliteSample =
  SequenceNumberedLidarliteSample
    { seqnum :: SequenceNum
    , val :: LidarliteSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedLidarliteSample :: Putter SequenceNumberedLidarliteSample
putSequenceNumberedLidarliteSample SequenceNumberedLidarliteSample{..} = do
  putSequenceNum seqnum
  putLidarliteSample val
getSequenceNumberedLidarliteSample :: Get SequenceNumberedLidarliteSample
getSequenceNumberedLidarliteSample = do
  seqnum <- getSequenceNum
  val <- getLidarliteSample
  return SequenceNumberedLidarliteSample{..}
instance Serialize SequenceNumberedLidarliteSample where
  put = putSequenceNumberedLidarliteSample
  get = getSequenceNumberedLidarliteSample
arbitrarySequenceNumberedLidarliteSample :: Q.Gen SequenceNumberedLidarliteSample
arbitrarySequenceNumberedLidarliteSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedLidarliteSample{..}
instance Q.Arbitrary SequenceNumberedLidarliteSample where
  arbitrary = arbitrarySequenceNumberedLidarliteSample
instance ToJSON SequenceNumberedLidarliteSample
instance FromJSON SequenceNumberedLidarliteSample