{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Px4flowSample where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct px4flow_sample
  { frame_count :: (Stored Uint16)
  ; pixel_flow_x_sum :: (Stored Sint16)
  ; pixel_flow_y_sum :: (Stored Sint16)
  ; flow_comp_m_x :: (Stored Sint16)
  ; flow_comp_m_y :: (Stored Sint16)
  ; quality :: (Stored Sint16)
  ; gyro_x_rate :: (Stored Sint16)
  ; gyro_y_rate :: (Stored Sint16)
  ; gyro_z_rate :: (Stored Sint16)
  ; gyro_range :: (Stored Uint8)
  ; sonar_timestamp :: (Stored Uint8)
  ; ground_distance :: (Stored Sint16)
  ; samplefail :: (Stored IBool)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packPx4flowSample :: WrappedPackRep ('Struct "px4flow_sample")
packPx4flowSample = wrapPackRep "px4flow_sample" $
  packStruct [ packLabel frame_count
             , packLabel pixel_flow_x_sum
             , packLabel pixel_flow_y_sum
             , packLabel flow_comp_m_x
             , packLabel flow_comp_m_y
             , packLabel quality
             , packLabel gyro_x_rate
             , packLabel gyro_y_rate
             , packLabel gyro_z_rate
             , packLabel gyro_range
             , packLabel sonar_timestamp
             , packLabel ground_distance
             , packLabel samplefail
             , packLabel time
             ]
instance Packable ('Struct "px4flow_sample") where
  packRep = wrappedPackRep packPx4flowSample
px4flowSampleTypesModule :: Module
px4flowSampleTypesModule = package "px4flow_sample_types" $ do
  defStruct (Proxy :: Proxy "px4flow_sample")
  depend serializeModule
  wrappedPackMod packPx4flowSample
  depend TimeMicros.timeMicrosTypesModule