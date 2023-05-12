{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.MagnetometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct magnetometer_sample
  { initfail :: (Stored IBool)
  ; samplefail :: (Stored IBool)
  ; sample :: Struct xyz
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packMagnetometerSample :: WrappedPackRep ('Struct "magnetometer_sample")
packMagnetometerSample = wrapPackRep "magnetometer_sample" $
  packStruct [ packLabel initfail
             , packLabel samplefail
             , packLabel sample
             , packLabel time
             ]
instance Packable ('Struct "magnetometer_sample") where
  packRep = wrappedPackRep packMagnetometerSample
magnetometerSampleTypesModule :: Module
magnetometerSampleTypesModule = package "magnetometer_sample_types" $ do
  defStruct (Proxy :: Proxy "magnetometer_sample")
  depend serializeModule
  wrappedPackMod packMagnetometerSample
  depend Xyz.xyzTypesModule
  depend TimeMicros.timeMicrosTypesModule