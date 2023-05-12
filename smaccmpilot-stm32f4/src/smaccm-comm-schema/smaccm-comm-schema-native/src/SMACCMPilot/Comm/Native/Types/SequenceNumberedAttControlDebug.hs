{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedAttControlDebug where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.AttControlDebug
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedAttControlDebug =
  SequenceNumberedAttControlDebug
    { seqnum :: SequenceNum
    , val :: AttControlDebug
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedAttControlDebug :: Putter SequenceNumberedAttControlDebug
putSequenceNumberedAttControlDebug SequenceNumberedAttControlDebug{..} = do
  putSequenceNum seqnum
  putAttControlDebug val
getSequenceNumberedAttControlDebug :: Get SequenceNumberedAttControlDebug
getSequenceNumberedAttControlDebug = do
  seqnum <- getSequenceNum
  val <- getAttControlDebug
  return SequenceNumberedAttControlDebug{..}
instance Serialize SequenceNumberedAttControlDebug where
  put = putSequenceNumberedAttControlDebug
  get = getSequenceNumberedAttControlDebug
arbitrarySequenceNumberedAttControlDebug :: Q.Gen SequenceNumberedAttControlDebug
arbitrarySequenceNumberedAttControlDebug = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedAttControlDebug{..}
instance Q.Arbitrary SequenceNumberedAttControlDebug where
  arbitrary = arbitrarySequenceNumberedAttControlDebug
instance ToJSON SequenceNumberedAttControlDebug
instance FromJSON SequenceNumberedAttControlDebug