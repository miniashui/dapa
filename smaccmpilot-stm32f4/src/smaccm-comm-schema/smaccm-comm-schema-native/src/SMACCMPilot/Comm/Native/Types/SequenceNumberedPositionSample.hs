{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPositionSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.PositionSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPositionSample =
  SequenceNumberedPositionSample
    { seqnum :: SequenceNum
    , val :: PositionSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPositionSample :: Putter SequenceNumberedPositionSample
putSequenceNumberedPositionSample SequenceNumberedPositionSample{..} = do
  putSequenceNum seqnum
  putPositionSample val
getSequenceNumberedPositionSample :: Get SequenceNumberedPositionSample
getSequenceNumberedPositionSample = do
  seqnum <- getSequenceNum
  val <- getPositionSample
  return SequenceNumberedPositionSample{..}
instance Serialize SequenceNumberedPositionSample where
  put = putSequenceNumberedPositionSample
  get = getSequenceNumberedPositionSample
arbitrarySequenceNumberedPositionSample :: Q.Gen SequenceNumberedPositionSample
arbitrarySequenceNumberedPositionSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPositionSample{..}
instance Q.Arbitrary SequenceNumberedPositionSample where
  arbitrary = arbitrarySequenceNumberedPositionSample
instance ToJSON SequenceNumberedPositionSample
instance FromJSON SequenceNumberedPositionSample