{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedFloat =
  SequenceNumberedFloat
    { seqnum :: SequenceNum
    , val :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedFloat :: Putter SequenceNumberedFloat
putSequenceNumberedFloat SequenceNumberedFloat{..} = do
  putSequenceNum seqnum
  putFloat32be val
getSequenceNumberedFloat :: Get SequenceNumberedFloat
getSequenceNumberedFloat = do
  seqnum <- getSequenceNum
  val <- getFloat32be
  return SequenceNumberedFloat{..}
instance Serialize SequenceNumberedFloat where
  put = putSequenceNumberedFloat
  get = getSequenceNumberedFloat
arbitrarySequenceNumberedFloat :: Q.Gen SequenceNumberedFloat
arbitrarySequenceNumberedFloat = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedFloat{..}
instance Q.Arbitrary SequenceNumberedFloat where
  arbitrary = arbitrarySequenceNumberedFloat
instance ToJSON SequenceNumberedFloat
instance FromJSON SequenceNumberedFloat