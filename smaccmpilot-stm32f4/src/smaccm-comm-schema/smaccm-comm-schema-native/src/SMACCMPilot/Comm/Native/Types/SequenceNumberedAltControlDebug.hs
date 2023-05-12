{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedAltControlDebug where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.AltControlDebug
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedAltControlDebug =
  SequenceNumberedAltControlDebug
    { seqnum :: SequenceNum
    , val :: AltControlDebug
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedAltControlDebug :: Putter SequenceNumberedAltControlDebug
putSequenceNumberedAltControlDebug SequenceNumberedAltControlDebug{..} = do
  putSequenceNum seqnum
  putAltControlDebug val
getSequenceNumberedAltControlDebug :: Get SequenceNumberedAltControlDebug
getSequenceNumberedAltControlDebug = do
  seqnum <- getSequenceNum
  val <- getAltControlDebug
  return SequenceNumberedAltControlDebug{..}
instance Serialize SequenceNumberedAltControlDebug where
  put = putSequenceNumberedAltControlDebug
  get = getSequenceNumberedAltControlDebug
arbitrarySequenceNumberedAltControlDebug :: Q.Gen SequenceNumberedAltControlDebug
arbitrarySequenceNumberedAltControlDebug = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedAltControlDebug{..}
instance Q.Arbitrary SequenceNumberedAltControlDebug where
  arbitrary = arbitrarySequenceNumberedAltControlDebug
instance ToJSON SequenceNumberedAltControlDebug
instance FromJSON SequenceNumberedAltControlDebug