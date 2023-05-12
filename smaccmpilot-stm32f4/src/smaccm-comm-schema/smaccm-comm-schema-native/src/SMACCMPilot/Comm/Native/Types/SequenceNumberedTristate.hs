{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedTristate where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.Tristate
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedTristate =
  SequenceNumberedTristate
    { seqnum :: SequenceNum
    , val :: Tristate
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedTristate :: Putter SequenceNumberedTristate
putSequenceNumberedTristate SequenceNumberedTristate{..} = do
  putSequenceNum seqnum
  putTristate val
getSequenceNumberedTristate :: Get SequenceNumberedTristate
getSequenceNumberedTristate = do
  seqnum <- getSequenceNum
  val <- getTristate
  return SequenceNumberedTristate{..}
instance Serialize SequenceNumberedTristate where
  put = putSequenceNumberedTristate
  get = getSequenceNumberedTristate
arbitrarySequenceNumberedTristate :: Q.Gen SequenceNumberedTristate
arbitrarySequenceNumberedTristate = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedTristate{..}
instance Q.Arbitrary SequenceNumberedTristate where
  arbitrary = arbitrarySequenceNumberedTristate
instance ToJSON SequenceNumberedTristate
instance FromJSON SequenceNumberedTristate