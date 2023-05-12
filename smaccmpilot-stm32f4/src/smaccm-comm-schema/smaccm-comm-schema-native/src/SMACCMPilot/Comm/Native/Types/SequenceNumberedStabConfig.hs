{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedStabConfig where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.StabConfig
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedStabConfig =
  SequenceNumberedStabConfig
    { seqnum :: SequenceNum
    , val :: StabConfig
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedStabConfig :: Putter SequenceNumberedStabConfig
putSequenceNumberedStabConfig SequenceNumberedStabConfig{..} = do
  putSequenceNum seqnum
  putStabConfig val
getSequenceNumberedStabConfig :: Get SequenceNumberedStabConfig
getSequenceNumberedStabConfig = do
  seqnum <- getSequenceNum
  val <- getStabConfig
  return SequenceNumberedStabConfig{..}
instance Serialize SequenceNumberedStabConfig where
  put = putSequenceNumberedStabConfig
  get = getSequenceNumberedStabConfig
arbitrarySequenceNumberedStabConfig :: Q.Gen SequenceNumberedStabConfig
arbitrarySequenceNumberedStabConfig = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedStabConfig{..}
instance Q.Arbitrary SequenceNumberedStabConfig where
  arbitrary = arbitrarySequenceNumberedStabConfig
instance ToJSON SequenceNumberedStabConfig
instance FromJSON SequenceNumberedStabConfig