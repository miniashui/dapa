{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedControlOutput where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ControlOutput
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedControlOutput =
  SequenceNumberedControlOutput
    { seqnum :: SequenceNum
    , val :: ControlOutput
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedControlOutput :: Putter SequenceNumberedControlOutput
putSequenceNumberedControlOutput SequenceNumberedControlOutput{..} = do
  putSequenceNum seqnum
  putControlOutput val
getSequenceNumberedControlOutput :: Get SequenceNumberedControlOutput
getSequenceNumberedControlOutput = do
  seqnum <- getSequenceNum
  val <- getControlOutput
  return SequenceNumberedControlOutput{..}
instance Serialize SequenceNumberedControlOutput where
  put = putSequenceNumberedControlOutput
  get = getSequenceNumberedControlOutput
arbitrarySequenceNumberedControlOutput :: Q.Gen SequenceNumberedControlOutput
arbitrarySequenceNumberedControlOutput = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedControlOutput{..}
instance Q.Arbitrary SequenceNumberedControlOutput where
  arbitrary = arbitrarySequenceNumberedControlOutput
instance ToJSON SequenceNumberedControlOutput
instance FromJSON SequenceNumberedControlOutput