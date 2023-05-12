{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedThrottleUi where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.ThrottleUi
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedThrottleUi =
  SequenceNumberedThrottleUi
    { seqnum :: SequenceNum
    , val :: ThrottleUi
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedThrottleUi :: Putter SequenceNumberedThrottleUi
putSequenceNumberedThrottleUi SequenceNumberedThrottleUi{..} = do
  putSequenceNum seqnum
  putThrottleUi val
getSequenceNumberedThrottleUi :: Get SequenceNumberedThrottleUi
getSequenceNumberedThrottleUi = do
  seqnum <- getSequenceNum
  val <- getThrottleUi
  return SequenceNumberedThrottleUi{..}
instance Serialize SequenceNumberedThrottleUi where
  put = putSequenceNumberedThrottleUi
  get = getSequenceNumberedThrottleUi
arbitrarySequenceNumberedThrottleUi :: Q.Gen SequenceNumberedThrottleUi
arbitrarySequenceNumberedThrottleUi = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedThrottleUi{..}
instance Q.Arbitrary SequenceNumberedThrottleUi where
  arbitrary = arbitrarySequenceNumberedThrottleUi
instance ToJSON SequenceNumberedThrottleUi
instance FromJSON SequenceNumberedThrottleUi