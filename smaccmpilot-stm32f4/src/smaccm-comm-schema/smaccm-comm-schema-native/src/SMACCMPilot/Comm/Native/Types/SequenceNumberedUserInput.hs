{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInput where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.UserInput
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedUserInput =
  SequenceNumberedUserInput
    { seqnum :: SequenceNum
    , val :: UserInput
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedUserInput :: Putter SequenceNumberedUserInput
putSequenceNumberedUserInput SequenceNumberedUserInput{..} = do
  putSequenceNum seqnum
  putUserInput val
getSequenceNumberedUserInput :: Get SequenceNumberedUserInput
getSequenceNumberedUserInput = do
  seqnum <- getSequenceNum
  val <- getUserInput
  return SequenceNumberedUserInput{..}
instance Serialize SequenceNumberedUserInput where
  put = putSequenceNumberedUserInput
  get = getSequenceNumberedUserInput
arbitrarySequenceNumberedUserInput :: Q.Gen SequenceNumberedUserInput
arbitrarySequenceNumberedUserInput = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedUserInput{..}
instance Q.Arbitrary SequenceNumberedUserInput where
  arbitrary = arbitrarySequenceNumberedUserInput
instance ToJSON SequenceNumberedUserInput
instance FromJSON SequenceNumberedUserInput