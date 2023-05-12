{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPidConfig where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.PidConfig
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPidConfig =
  SequenceNumberedPidConfig
    { seqnum :: SequenceNum
    , val :: PidConfig
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPidConfig :: Putter SequenceNumberedPidConfig
putSequenceNumberedPidConfig SequenceNumberedPidConfig{..} = do
  putSequenceNum seqnum
  putPidConfig val
getSequenceNumberedPidConfig :: Get SequenceNumberedPidConfig
getSequenceNumberedPidConfig = do
  seqnum <- getSequenceNum
  val <- getPidConfig
  return SequenceNumberedPidConfig{..}
instance Serialize SequenceNumberedPidConfig where
  put = putSequenceNumberedPidConfig
  get = getSequenceNumberedPidConfig
arbitrarySequenceNumberedPidConfig :: Q.Gen SequenceNumberedPidConfig
arbitrarySequenceNumberedPidConfig = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPidConfig{..}
instance Q.Arbitrary SequenceNumberedPidConfig where
  arbitrary = arbitrarySequenceNumberedPidConfig
instance ToJSON SequenceNumberedPidConfig
instance FromJSON SequenceNumberedPidConfig