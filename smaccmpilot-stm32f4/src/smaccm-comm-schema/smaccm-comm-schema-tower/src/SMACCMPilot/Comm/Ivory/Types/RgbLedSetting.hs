{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.RgbLedSetting where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct rgb_led_setting
  { red :: (Stored Uint8)
  ; green :: (Stored Uint8)
  ; blue :: (Stored Uint8)
  }
|]
packRgbLedSetting :: WrappedPackRep ('Struct "rgb_led_setting")
packRgbLedSetting = wrapPackRep "rgb_led_setting" $
  packStruct [ packLabel red
             , packLabel green
             , packLabel blue
             ]
instance Packable ('Struct "rgb_led_setting") where
  packRep = wrappedPackRep packRgbLedSetting
rgbLedSettingTypesModule :: Module
rgbLedSettingTypesModule = package "rgb_led_setting_types" $ do
  defStruct (Proxy :: Proxy "rgb_led_setting")
  depend serializeModule
  wrappedPackMod packRgbLedSetting