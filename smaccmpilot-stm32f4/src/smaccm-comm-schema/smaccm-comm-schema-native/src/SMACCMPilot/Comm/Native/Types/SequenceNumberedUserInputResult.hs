{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInputResult where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.UserInputResult
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedUserInputResult =
  SequenceNumberedUserInputResult
    { seqnum :: SequenceNum
    , val :: UserInputResult
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedUserInputResult :: Putter SequenceNumberedUserInputResult
putSequenceNumberedUserInputResult SequenceNumberedUserInputResult{..} = do
  putSequenceNum seqnum
  putUserInputResult val
getSequenceNumberedUserInputResult :: Get SequenceNumberedUserInputResult
getSequenceNumberedUserInputResult = do
  seqnum <- getSequenceNum
  val <- getUserInputResult
  return SequenceNumberedUserInputResult{..}
instance Serialize SequenceNumberedUserInputResult where
  put = putSequenceNumberedUserInputResult
  get = getSequenceNumberedUserInputResult
arbitrarySequenceNumberedUserInputResult :: Q.Gen SequenceNumberedUserInputResult
arbitrarySequenceNumberedUserInputResult = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedUserInputResult{..}
instance Q.Arbitrary SequenceNumberedUserInputResult where
  arbitrary = arbitrarySequenceNumberedUserInputResult
instance ToJSON SequenceNumberedUserInputResult
instance FromJSON SequenceNumberedUserInputResult