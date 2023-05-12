{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.GyroscopeSample where
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct gyroscope_sample
  { initfail :: (Stored IBool)
  ; samplefail :: (Stored IBool)
  ; sample :: Struct xyz
  ; temperature :: (Stored IFloat)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packGyroscopeSample :: WrappedPackRep ('Struct "gyroscope_sample")
packGyroscopeSample = wrapPackRep "gyroscope_sample" $
  packStruct [ packLabel initfail
             , packLabel samplefail
             , packLabel sample
             , packLabel temperature
             , packLabel time
             ]
instance Packable ('Struct "gyroscope_sample") where
  packRep = wrappedPackRep packGyroscopeSample
gyroscopeSampleTypesModule :: Module
gyroscopeSampleTypesModule = package "gyroscope_sample_types" $ do
  defStruct (Proxy :: Proxy "gyroscope_sample")
  depend serializeModule
  wrappedPackMod packGyroscopeSample
  depend Xyz.xyzTypesModule
  depend TimeMicros.timeMicrosTypesModule