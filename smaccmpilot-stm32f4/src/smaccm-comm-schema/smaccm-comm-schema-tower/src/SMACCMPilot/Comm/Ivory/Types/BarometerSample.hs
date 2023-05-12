{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.BarometerSample where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct barometer_sample
  { initfail :: (Stored IBool)
  ; samplefail :: (Stored IBool)
  ; pressure :: (Stored IFloat)
  ; temperature :: (Stored IFloat)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packBarometerSample :: WrappedPackRep ('Struct "barometer_sample")
packBarometerSample = wrapPackRep "barometer_sample" $
  packStruct [ packLabel initfail
             , packLabel samplefail
             , packLabel pressure
             , packLabel temperature
             , packLabel time
             ]
instance Packable ('Struct "barometer_sample") where
  packRep = wrappedPackRep packBarometerSample
barometerSampleTypesModule :: Module
barometerSampleTypesModule = package "barometer_sample_types" $ do
  defStruct (Proxy :: Proxy "barometer_sample")
  depend serializeModule
  wrappedPackMod packBarometerSample
  depend TimeMicros.timeMicrosTypesModule