{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedControlLaw where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ControlLaw
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedControlLaw =
  SequenceNumberedControlLaw
    { seqnum :: SequenceNum
    , val :: ControlLaw
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedControlLaw :: Putter SequenceNumberedControlLaw
putSequenceNumberedControlLaw SequenceNumberedControlLaw{..} = do
  putSequenceNum seqnum
  putControlLaw val
getSequenceNumberedControlLaw :: Get SequenceNumberedControlLaw
getSequenceNumberedControlLaw = do
  seqnum <- getSequenceNum
  val <- getControlLaw
  return SequenceNumberedControlLaw{..}
instance Serialize SequenceNumberedControlLaw where
  put = putSequenceNumberedControlLaw
  get = getSequenceNumberedControlLaw
arbitrarySequenceNumberedControlLaw :: Q.Gen SequenceNumberedControlLaw
arbitrarySequenceNumberedControlLaw = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedControlLaw{..}
instance Q.Arbitrary SequenceNumberedControlLaw where
  arbitrary = arbitrarySequenceNumberedControlLaw
instance ToJSON SequenceNumberedControlLaw
instance FromJSON SequenceNumberedControlLaw