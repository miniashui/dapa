{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.AccelerometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct accelerometer_sample
  { initfail :: (Stored IBool)
  ; samplefail :: (Stored IBool)
  ; sample :: Struct xyz
  ; temperature :: (Stored IFloat)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packAccelerometerSample :: WrappedPackRep ('Struct "accelerometer_sample")
packAccelerometerSample = wrapPackRep "accelerometer_sample" $
  packStruct [ packLabel initfail
             , packLabel samplefail
             , packLabel sample
             , packLabel temperature
             , packLabel time
             ]
instance Packable ('Struct "accelerometer_sample") where
  packRep = wrappedPackRep packAccelerometerSample
accelerometerSampleTypesModule :: Module
accelerometerSampleTypesModule = package "accelerometer_sample_types" $ do
  defStruct (Proxy :: Proxy "accelerometer_sample")
  depend serializeModule
  wrappedPackMod packAccelerometerSample
  depend Xyz.xyzTypesModule
  depend TimeMicros.timeMicrosTypesModule