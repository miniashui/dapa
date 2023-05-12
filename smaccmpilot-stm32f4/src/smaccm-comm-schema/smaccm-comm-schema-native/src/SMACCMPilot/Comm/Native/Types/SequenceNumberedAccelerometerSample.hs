{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedAccelerometerSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.AccelerometerSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedAccelerometerSample =
  SequenceNumberedAccelerometerSample
    { seqnum :: SequenceNum
    , val :: AccelerometerSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedAccelerometerSample :: Putter SequenceNumberedAccelerometerSample
putSequenceNumberedAccelerometerSample SequenceNumberedAccelerometerSample{..} = do
  putSequenceNum seqnum
  putAccelerometerSample val
getSequenceNumberedAccelerometerSample :: Get SequenceNumberedAccelerometerSample
getSequenceNumberedAccelerometerSample = do
  seqnum <- getSequenceNum
  val <- getAccelerometerSample
  return SequenceNumberedAccelerometerSample{..}
instance Serialize SequenceNumberedAccelerometerSample where
  put = putSequenceNumberedAccelerometerSample
  get = getSequenceNumberedAccelerometerSample
arbitrarySequenceNumberedAccelerometerSample :: Q.Gen SequenceNumberedAccelerometerSample
arbitrarySequenceNumberedAccelerometerSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedAccelerometerSample{..}
instance Q.Arbitrary SequenceNumberedAccelerometerSample where
  arbitrary = arbitrarySequenceNumberedAccelerometerSample
instance ToJSON SequenceNumberedAccelerometerSample
instance FromJSON SequenceNumberedAccelerometerSample