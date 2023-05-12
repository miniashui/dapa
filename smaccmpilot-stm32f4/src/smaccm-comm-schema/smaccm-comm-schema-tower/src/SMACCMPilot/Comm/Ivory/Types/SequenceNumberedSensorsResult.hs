{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedSensorsResult where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.SensorsResult as SensorsResult
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_sensors_result
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct sensors_result
  }
|]
packSequenceNumberedSensorsResult :: WrappedPackRep ('Struct "sequence_numbered_sensors_result")
packSequenceNumberedSensorsResult = wrapPackRep "sequence_numbered_sensors_result" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_sensors_result") where
  packRep = wrappedPackRep packSequenceNumberedSensorsResult
sequenceNumberedSensorsResultTypesModule :: Module
sequenceNumberedSensorsResultTypesModule = package "sequence_numbered_sensors_result_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_sensors_result")
  depend serializeModule
  wrappedPackMod packSequenceNumberedSensorsResult
  depend SequenceNum.sequenceNumTypesModule
  depend SensorsResult.sensorsResultTypesModule