{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedMagnetometerSample where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.MagnetometerSample
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedMagnetometerSample =
  SequenceNumberedMagnetometerSample
    { seqnum :: SequenceNum
    , val :: MagnetometerSample
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedMagnetometerSample :: Putter SequenceNumberedMagnetometerSample
putSequenceNumberedMagnetometerSample SequenceNumberedMagnetometerSample{..} = do
  putSequenceNum seqnum
  putMagnetometerSample val
getSequenceNumberedMagnetometerSample :: Get SequenceNumberedMagnetometerSample
getSequenceNumberedMagnetometerSample = do
  seqnum <- getSequenceNum
  val <- getMagnetometerSample
  return SequenceNumberedMagnetometerSample{..}
instance Serialize SequenceNumberedMagnetometerSample where
  put = putSequenceNumberedMagnetometerSample
  get = getSequenceNumberedMagnetometerSample
arbitrarySequenceNumberedMagnetometerSample :: Q.Gen SequenceNumberedMagnetometerSample
arbitrarySequenceNumberedMagnetometerSample = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedMagnetometerSample{..}
instance Q.Arbitrary SequenceNumberedMagnetometerSample where
  arbitrary = arbitrarySequenceNumberedMagnetometerSample
instance ToJSON SequenceNumberedMagnetometerSample
instance FromJSON SequenceNumberedMagnetometerSample