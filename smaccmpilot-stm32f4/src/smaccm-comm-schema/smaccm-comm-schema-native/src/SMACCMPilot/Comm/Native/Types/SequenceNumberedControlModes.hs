{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedControlModes where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ControlModes
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedControlModes =
  SequenceNumberedControlModes
    { seqnum :: SequenceNum
    , val :: ControlModes
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedControlModes :: Putter SequenceNumberedControlModes
putSequenceNumberedControlModes SequenceNumberedControlModes{..} = do
  putSequenceNum seqnum
  putControlModes val
getSequenceNumberedControlModes :: Get SequenceNumberedControlModes
getSequenceNumberedControlModes = do
  seqnum <- getSequenceNum
  val <- getControlModes
  return SequenceNumberedControlModes{..}
instance Serialize SequenceNumberedControlModes where
  put = putSequenceNumberedControlModes
  get = getSequenceNumberedControlModes
arbitrarySequenceNumberedControlModes :: Q.Gen SequenceNumberedControlModes
arbitrarySequenceNumberedControlModes = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedControlModes{..}
instance Q.Arbitrary SequenceNumberedControlModes where
  arbitrary = arbitrarySequenceNumberedControlModes
instance ToJSON SequenceNumberedControlModes
instance FromJSON SequenceNumberedControlModes