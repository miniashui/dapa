{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRgbLedSetting where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.RgbLedSetting as RgbLedSetting
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_rgb_led_setting
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct rgb_led_setting
  }
|]
packSequenceNumberedRgbLedSetting :: WrappedPackRep ('Struct "sequence_numbered_rgb_led_setting")
packSequenceNumberedRgbLedSetting = wrapPackRep "sequence_numbered_rgb_led_setting" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_rgb_led_setting") where
  packRep = wrappedPackRep packSequenceNumberedRgbLedSetting
sequenceNumberedRgbLedSettingTypesModule :: Module
sequenceNumberedRgbLedSettingTypesModule = package "sequence_numbered_rgb_led_setting_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_rgb_led_setting")
  depend serializeModule
  wrappedPackMod packSequenceNumberedRgbLedSetting
  depend SequenceNum.sequenceNumTypesModule
  depend RgbLedSetting.rgbLedSettingTypesModule