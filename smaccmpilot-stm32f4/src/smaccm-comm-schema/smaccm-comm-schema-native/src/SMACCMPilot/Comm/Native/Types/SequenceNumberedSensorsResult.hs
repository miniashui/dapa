{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedSensorsResult where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.SensorsResult
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedSensorsResult =
  SequenceNumberedSensorsResult
    { seqnum :: SequenceNum
    , val :: SensorsResult
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedSensorsResult :: Putter SequenceNumberedSensorsResult
putSequenceNumberedSensorsResult SequenceNumberedSensorsResult{..} = do
  putSequenceNum seqnum
  putSensorsResult val
getSequenceNumberedSensorsResult :: Get SequenceNumberedSensorsResult
getSequenceNumberedSensorsResult = do
  seqnum <- getSequenceNum
  val <- getSensorsResult
  return SequenceNumberedSensorsResult{..}
instance Serialize SequenceNumberedSensorsResult where
  put = putSequenceNumberedSensorsResult
  get = getSequenceNumberedSensorsResult
arbitrarySequenceNumberedSensorsResult :: Q.Gen SequenceNumberedSensorsResult
arbitrarySequenceNumberedSensorsResult = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedSensorsResult{..}
instance Q.Arbitrary SequenceNumberedSensorsResult where
  arbitrary = arbitrarySequenceNumberedSensorsResult
instance ToJSON SequenceNumberedSensorsResult
instance FromJSON SequenceNumberedSensorsResult