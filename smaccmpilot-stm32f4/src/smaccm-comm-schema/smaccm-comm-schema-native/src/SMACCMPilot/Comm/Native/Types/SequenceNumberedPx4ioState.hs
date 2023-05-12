{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4ioState where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.Px4ioState
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPx4ioState =
  SequenceNumberedPx4ioState
    { seqnum :: SequenceNum
    , val :: Px4ioState
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPx4ioState :: Putter SequenceNumberedPx4ioState
putSequenceNumberedPx4ioState SequenceNumberedPx4ioState{..} = do
  putSequenceNum seqnum
  putPx4ioState val
getSequenceNumberedPx4ioState :: Get SequenceNumberedPx4ioState
getSequenceNumberedPx4ioState = do
  seqnum <- getSequenceNum
  val <- getPx4ioState
  return SequenceNumberedPx4ioState{..}
instance Serialize SequenceNumberedPx4ioState where
  put = putSequenceNumberedPx4ioState
  get = getSequenceNumberedPx4ioState
arbitrarySequenceNumberedPx4ioState :: Q.Gen SequenceNumberedPx4ioState
arbitrarySequenceNumberedPx4ioState = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPx4ioState{..}
instance Q.Arbitrary SequenceNumberedPx4ioState where
  arbitrary = arbitrarySequenceNumberedPx4ioState
instance ToJSON SequenceNumberedPx4ioState
instance FromJSON SequenceNumberedPx4ioState