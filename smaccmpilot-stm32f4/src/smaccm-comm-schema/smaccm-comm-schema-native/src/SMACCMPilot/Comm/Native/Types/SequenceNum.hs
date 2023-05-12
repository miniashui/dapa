{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNum where
import Data.Word
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
newtype SequenceNum =
  SequenceNum { unSequenceNum :: Word32
              } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNum :: Putter SequenceNum
putSequenceNum (SequenceNum a) = putWord32be a
getSequenceNum :: Get SequenceNum
getSequenceNum = do
  a <- getWord32be
  return (SequenceNum a)
instance Serialize SequenceNum where
  put = putSequenceNum
  get = getSequenceNum
arbitrarySequenceNum :: Q.Gen SequenceNum
arbitrarySequenceNum = do
  a <- Q.arbitrary
  return (SequenceNum a)
instance Q.Arbitrary SequenceNum where
  arbitrary = arbitrarySequenceNum
instance ToJSON SequenceNum
instance FromJSON SequenceNum