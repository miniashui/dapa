{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.LidarliteSample where
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct lidarlite_sample
  { samplefail :: (Stored IBool)
  ; distance :: (Stored IFloat)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packLidarliteSample :: WrappedPackRep ('Struct "lidarlite_sample")
packLidarliteSample = wrapPackRep "lidarlite_sample" $
  packStruct [ packLabel samplefail
             , packLabel distance
             , packLabel time
             ]
instance Packable ('Struct "lidarlite_sample") where
  packRep = wrappedPackRep packLidarliteSample
lidarliteSampleTypesModule :: Module
lidarliteSampleTypesModule = package "lidarlite_sample_types" $ do
  defStruct (Proxy :: Proxy "lidarlite_sample")
  depend serializeModule
  wrappedPackMod packLidarliteSample
  depend TimeMicros.timeMicrosTypesModule