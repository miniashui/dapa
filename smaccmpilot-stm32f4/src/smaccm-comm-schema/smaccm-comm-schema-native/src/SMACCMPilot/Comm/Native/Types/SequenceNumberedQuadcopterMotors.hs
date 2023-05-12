{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedQuadcopterMotors where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.QuadcopterMotors
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedQuadcopterMotors =
  SequenceNumberedQuadcopterMotors
    { seqnum :: SequenceNum
    , val :: QuadcopterMotors
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedQuadcopterMotors :: Putter SequenceNumberedQuadcopterMotors
putSequenceNumberedQuadcopterMotors SequenceNumberedQuadcopterMotors{..} = do
  putSequenceNum seqnum
  putQuadcopterMotors val
getSequenceNumberedQuadcopterMotors :: Get SequenceNumberedQuadcopterMotors
getSequenceNumberedQuadcopterMotors = do
  seqnum <- getSequenceNum
  val <- getQuadcopterMotors
  return SequenceNumberedQuadcopterMotors{..}
instance Serialize SequenceNumberedQuadcopterMotors where
  put = putSequenceNumberedQuadcopterMotors
  get = getSequenceNumberedQuadcopterMotors
arbitrarySequenceNumberedQuadcopterMotors :: Q.Gen SequenceNumberedQuadcopterMotors
arbitrarySequenceNumberedQuadcopterMotors = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedQuadcopterMotors{..}
instance Q.Arbitrary SequenceNumberedQuadcopterMotors where
  arbitrary = arbitrarySequenceNumberedQuadcopterMotors
instance ToJSON SequenceNumberedQuadcopterMotors
instance FromJSON SequenceNumberedQuadcopterMotors