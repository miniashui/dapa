{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowIntegralSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedPx4flowIntegralSample =
  SequenceNumberedPx4flowIntegralSample
    { seqnum :: SequenceNum
    , val :: Px4flowIntegralSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedPx4flowIntegralSample :: Putter SequenceNumberedPx4flowIntegralSample
putSequenceNumberedPx4flowIntegralSample SequenceNumberedPx4flowIntegralSample{..} = do
  putSequenceNum seqnum
  putPx4flowIntegralSample val
getSequenceNumberedPx4flowIntegralSample :: Get SequenceNumberedPx4flowIntegralSample
getSequenceNumberedPx4flowIntegralSample = do
  seqnum <- getSequenceNum
  val <- getPx4flowIntegralSample
  return SequenceNumberedPx4flowIntegralSample{..}
instance Serialize SequenceNumberedPx4flowIntegralSample where
  put = putSequenceNumberedPx4flowIntegralSample
  get = getSequenceNumberedPx4flowIntegralSample
arbitrarySequenceNumberedPx4flowIntegralSample :: Q.Gen SequenceNumberedPx4flowIntegralSample
arbitrarySequenceNumberedPx4flowIntegralSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedPx4flowIntegralSample{..}
instance Q.Arbitrary SequenceNumberedPx4flowIntegralSample where
  arbitrary = arbitrarySequenceNumberedPx4flowIntegralSample
instance ToJSON SequenceNumberedPx4flowIntegralSample
instance FromJSON SequenceNumberedPx4flowIntegralSample