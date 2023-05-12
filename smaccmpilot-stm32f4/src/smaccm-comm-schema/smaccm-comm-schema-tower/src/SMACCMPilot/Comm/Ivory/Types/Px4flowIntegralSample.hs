{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Px4flowIntegralSample where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct px4flow_integral_sample
  { frame_count_since_last_readout :: (Stored Uint16)
  ; pixel_flow_x_integral :: (Stored Sint16)
  ; pixel_flow_y_integral :: (Stored Sint16)
  ; gyro_x_rate_integral :: (Stored Sint16)
  ; gyro_y_rate_integral :: (Stored Sint16)
  ; gyro_z_rate_integral :: (Stored Sint16)
  ; integration_timespan :: (Stored Uint32)
  ; sonar_timestamp :: (Stored Uint32)
  ; ground_distance :: (Stored Sint16)
  ; gyro_temperature :: (Stored Sint16)
  ; quality :: (Stored Uint8)
  ; samplefail :: (Stored IBool)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packPx4flowIntegralSample :: WrappedPackRep ('Struct "px4flow_integral_sample")
packPx4flowIntegralSample = wrapPackRep "px4flow_integral_sample" $
  packStruct [ packLabel frame_count_since_last_readout
             , packLabel pixel_flow_x_integral
             , packLabel pixel_flow_y_integral
             , packLabel gyro_x_rate_integral
             , packLabel gyro_y_rate_integral
             , packLabel gyro_z_rate_integral
             , packLabel integration_timespan
             , packLabel sonar_timestamp
             , packLabel ground_distance
             , packLabel gyro_temperature
             , packLabel quality
             , packLabel samplefail
             , packLabel time
             ]
instance Packable ('Struct "px4flow_integral_sample") where
  packRep = wrappedPackRep packPx4flowIntegralSample
px4flowIntegralSampleTypesModule :: Module
px4flowIntegralSampleTypesModule = package "px4flow_integral_sample_types" $ do
  defStruct (Proxy :: Proxy "px4flow_integral_sample")
  depend serializeModule
  wrappedPackMod packPx4flowIntegralSample
  depend TimeMicros.timeMicrosTypesModule