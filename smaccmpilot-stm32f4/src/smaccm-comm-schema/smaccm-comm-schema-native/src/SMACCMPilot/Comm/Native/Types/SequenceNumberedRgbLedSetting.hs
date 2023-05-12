{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.SequenceNumberedRgbLedSetting where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import SMACCMPilot.Comm.Native.Types.RgbLedSetting
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data SequenceNumberedRgbLedSetting =
  SequenceNumberedRgbLedSetting
    { seqnum :: SequenceNum
    , val :: RgbLedSetting
    } deriving (Eq, Show, Data, Typeable, Generic)
putSequenceNumberedRgbLedSetting :: Putter SequenceNumberedRgbLedSetting
putSequenceNumberedRgbLedSetting SequenceNumberedRgbLedSetting{..} = do
  putSequenceNum seqnum
  putRgbLedSetting val
getSequenceNumberedRgbLedSetting :: Get SequenceNumberedRgbLedSetting
getSequenceNumberedRgbLedSetting = do
  seqnum <- getSequenceNum
  val <- getRgbLedSetting
  return SequenceNumberedRgbLedSetting{..}
instance Serialize SequenceNumberedRgbLedSetting where
  put = putSequenceNumberedRgbLedSetting
  get = getSequenceNumberedRgbLedSetting
arbitrarySequenceNumberedRgbLedSetting :: Q.Gen SequenceNumberedRgbLedSetting
arbitrarySequenceNumberedRgbLedSetting = do
  seqnum <- Q.arbitrary
  val <- Q.arbitrary
  return SequenceNumberedRgbLedSetting{..}
instance Q.Arbitrary SequenceNumberedRgbLedSetting where
  arbitrary = arbitrarySequenceNumberedRgbLedSetting
instance ToJSON SequenceNumberedRgbLedSetting
instance FromJSON SequenceNumberedRgbLedSetting