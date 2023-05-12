{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.RgbLedSetting where
import Data.Word
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data RgbLedSetting =
  RgbLedSetting
    { red :: Word8
    , green :: Word8
    , blue :: Word8
    } deriving (Eq, Show, Data, Typeable, Generic)
putRgbLedSetting :: Putter RgbLedSetting
putRgbLedSetting RgbLedSetting{..} = do
  putWord8 red
  putWord8 green
  putWord8 blue
getRgbLedSetting :: Get RgbLedSetting
getRgbLedSetting = do
  red <- getWord8
  green <- getWord8
  blue <- getWord8
  return RgbLedSetting{..}
instance Serialize RgbLedSetting where
  put = putRgbLedSetting
  get = getRgbLedSetting
arbitraryRgbLedSetting :: Q.Gen RgbLedSetting
arbitraryRgbLedSetting = do
  red <- Q.arbitrary
  green <- Q.arbitrary
  blue <- Q.arbitrary
  return RgbLedSetting{..}
instance Q.Arbitrary RgbLedSetting where
  arbitrary = arbitraryRgbLedSetting
instance ToJSON RgbLedSetting
instance FromJSON RgbLedSetting