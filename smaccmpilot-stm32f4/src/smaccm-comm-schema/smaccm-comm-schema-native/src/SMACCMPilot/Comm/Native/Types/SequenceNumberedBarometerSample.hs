{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedBarometerSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.BarometerSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedBarometerSample =
  SequenceNumberedBarometerSample
    { seqnum :: SequenceNum
    , val :: BarometerSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedBarometerSample :: Putter SequenceNumberedBarometerSample
putSequenceNumberedBarometerSample SequenceNumberedBarometerSample{..} = do
  putSequenceNum seqnum
  putBarometerSample val
getSequenceNumberedBarometerSample :: Get SequenceNumberedBarometerSample
getSequenceNumberedBarometerSample = do
  seqnum <- getSequenceNum
  val <- getBarometerSample
  return SequenceNumberedBarometerSample{..}
instance Serialize SequenceNumberedBarometerSample where
  put = putSequenceNumberedBarometerSample
  get = getSequenceNumberedBarometerSample
arbitrarySequenceNumberedBarometerSample :: Q.Gen SequenceNumberedBarometerSample
arbitrarySequenceNumberedBarometerSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedBarometerSample{..}
instance Q.Arbitrary SequenceNumberedBarometerSample where
  arbitrary = arbitrarySequenceNumberedBarometerSample
instance ToJSON SequenceNumberedBarometerSample
instance FromJSON SequenceNumberedBarometerSample