{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedControlSetpoint where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ControlSetpoint
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedControlSetpoint =
  SequenceNumberedControlSetpoint
    { seqnum :: SequenceNum
    , val :: ControlSetpoint
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedControlSetpoint :: Putter SequenceNumberedControlSetpoint
putSequenceNumberedControlSetpoint SequenceNumberedControlSetpoint{..} = do
  putSequenceNum seqnum
  putControlSetpoint val
getSequenceNumberedControlSetpoint :: Get SequenceNumberedControlSetpoint
getSequenceNumberedControlSetpoint = do
  seqnum <- getSequenceNum
  val <- getControlSetpoint
  return SequenceNumberedControlSetpoint{..}
instance Serialize SequenceNumberedControlSetpoint where
  put = putSequenceNumberedControlSetpoint
  get = getSequenceNumberedControlSetpoint
arbitrarySequenceNumberedControlSetpoint :: Q.Gen SequenceNumberedControlSetpoint
arbitrarySequenceNumberedControlSetpoint = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedControlSetpoint{..}
instance Q.Arbitrary SequenceNumberedControlSetpoint where
  arbitrary = arbitrarySequenceNumberedControlSetpoint
instance ToJSON SequenceNumberedControlSetpoint
instance FromJSON SequenceNumberedControlSetpoint