{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.PositionSample where
import qualified SMACCMPilot.Comm.Ivory.Types.GpsFix as GpsFix
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct position_sample
  { fix :: (Stored GpsFix.GpsFix)
  ; num_sv :: (Stored Uint8)
  ; dop :: (Stored IFloat)
  ; lat :: (Stored Sint32)
  ; lon :: (Stored Sint32)
  ; alt :: (Stored Sint32)
  ; vnorth :: (Stored Sint32)
  ; veast :: (Stored Sint32)
  ; vdown :: (Stored Sint32)
  ; vground :: (Stored Uint32)
  ; heading :: (Stored IFloat)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packPositionSample :: WrappedPackRep ('Struct "position_sample")
packPositionSample = wrapPackRep "position_sample" $
  packStruct [ packLabel fix
             , packLabel num_sv
             , packLabel dop
             , packLabel lat
             , packLabel lon
             , packLabel alt
             , packLabel vnorth
             , packLabel veast
             , packLabel vdown
             , packLabel vground
             , packLabel heading
             , packLabel time
             ]
instance Packable ('Struct "position_sample") where
  packRep = wrappedPackRep packPositionSample
positionSampleTypesModule :: Module
positionSampleTypesModule = package "position_sample_types" $ do
  defStruct (Proxy :: Proxy "position_sample")
  depend serializeModule
  wrappedPackMod packPositionSample
  depend GpsFix.gpsFixTypesModule
  depend TimeMicros.timeMicrosTypesModule