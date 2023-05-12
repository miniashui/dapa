{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Ivory.Interface.Vehicle.Consumer where
import qualified SMACCMPilot.Comm.Ivory.Types.Heartbeat as Heartbeat
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.GpsFix as GpsFix
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Ivory.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleMode as ThrottleMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Ivory.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Ivory.Types.UserInputResult as UserInputResult
import qualified SMACCMPilot.Comm.Ivory.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedSensorsResult as SequenceNumberedSensorsResult
import qualified SMACCMPilot.Comm.Ivory.Types.SensorsResult as SensorsResult
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.Quaternion as Quaternion
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedGyroscopeSample as SequenceNumberedGyroscopeSample
import qualified SMACCMPilot.Comm.Ivory.Types.GyroscopeSample as GyroscopeSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAccelerometerSample as SequenceNumberedAccelerometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.AccelerometerSample as AccelerometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedBarometerSample as SequenceNumberedBarometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.BarometerSample as BarometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedLidarliteSample as SequenceNumberedLidarliteSample
import qualified SMACCMPilot.Comm.Ivory.Types.LidarliteSample as LidarliteSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedMagnetometerSample as SequenceNumberedMagnetometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.MagnetometerSample as MagnetometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowIntegralSample as SequenceNumberedPx4flowIntegralSample
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowIntegralSample as Px4flowIntegralSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowSample as SequenceNumberedPx4flowSample
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowSample as Px4flowSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPositionSample as SequenceNumberedPositionSample
import qualified SMACCMPilot.Comm.Ivory.Types.PositionSample as PositionSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlSetpoint as SequenceNumberedControlSetpoint
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSetpoint as ControlSetpoint
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlOutput as SequenceNumberedControlOutput
import qualified SMACCMPilot.Comm.Ivory.Types.ControlOutput as ControlOutput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedQuadcopterMotors as SequenceNumberedQuadcopterMotors
import qualified SMACCMPilot.Comm.Ivory.Types.QuadcopterMotors as QuadcopterMotors
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAttControlDebug as SequenceNumberedAttControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.AttControlDebug as AttControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.PidState as PidState
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAltControlDebug as SequenceNumberedAltControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.AltControlDebug as AltControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4ioState as SequenceNumberedPx4ioState
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioState as Px4ioState
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioStatus as Px4ioStatus
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioAlarms as Px4ioAlarms
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedArmingStatus as SequenceNumberedArmingStatus
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingStatus as ArmingStatus
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedFloat as SequenceNumberedFloat
import SMACCMPilot.Comm.Ivory.Unpack
import Ivory.Language
import Ivory.Serialize
import Ivory.Stdlib
-- Define Consumer schema for Vehicle interface
data VehicleConsumer = VehicleConsumer
  { packedStatusGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlLawGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , rcInputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , userInputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , sensorsOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , gyroOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , accelOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , baroOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , lidarliteOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , magOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowIntOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , gpsOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlSetpointGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , motorOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , attControlDebugGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , altControlDebugGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4ioStateGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , armingStatusGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , batteryVoltageGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  }
vehicleConsumerParser :: forall s0 r b s2 s3 n
                       . (ANat n)
                      => ConstRef s2 ('Array n ('Stored Uint8))
                      -> Ref s3 ('Stored Uint32)
                      -> VehicleConsumer
                      -> Ivory ('Effects r b ('Scope s0)) IBool
vehicleConsumerParser arr offs iface = do
  unpackWithCallback arr offs $ \tag_ref -> do
    (tag :: Uint32) <- deref tag_ref
    cond [ (tag ==? 3156344986) ==> unpackWithCallback arr offs (packedStatusGetReqConsumer iface)
         , (tag ==? 301568917) ==> unpackWithCallback arr offs (controlLawGetReqConsumer iface)
         , (tag ==? 296944620) ==> unpackWithCallback arr offs (rcInputGetReqConsumer iface)
         , (tag ==? 399143934) ==> unpackWithCallback arr offs (userInputGetReqConsumer iface)
         , (tag ==? 26185883) ==> unpackWithCallback arr offs (sensorsOutputGetReqConsumer iface)
         , (tag ==? 82693526) ==> unpackWithCallback arr offs (gyroOutputGetReqConsumer iface)
         , (tag ==? 1941058076) ==> unpackWithCallback arr offs (accelOutputGetReqConsumer iface)
         , (tag ==? 3344129961) ==> unpackWithCallback arr offs (baroOutputGetReqConsumer iface)
         , (tag ==? 991289502) ==> unpackWithCallback arr offs (lidarliteOutputGetReqConsumer iface)
         , (tag ==? 143343139) ==> unpackWithCallback arr offs (magOutputGetReqConsumer iface)
         , (tag ==? 2862321756) ==> unpackWithCallback arr offs (px4flowIntOutputGetReqConsumer iface)
         , (tag ==? 359304658) ==> unpackWithCallback arr offs (px4flowOutputGetReqConsumer iface)
         , (tag ==? 3642047882) ==> unpackWithCallback arr offs (gpsOutputGetReqConsumer iface)
         , (tag ==? 1168870388) ==> unpackWithCallback arr offs (controlSetpointGetReqConsumer iface)
         , (tag ==? 2165647949) ==> unpackWithCallback arr offs (controlOutputGetReqConsumer iface)
         , (tag ==? 2700215595) ==> unpackWithCallback arr offs (motorOutputGetReqConsumer iface)
         , (tag ==? 1652180384) ==> unpackWithCallback arr offs (attControlDebugGetReqConsumer iface)
         , (tag ==? 3488192856) ==> unpackWithCallback arr offs (altControlDebugGetReqConsumer iface)
         , (tag ==? 3679040117) ==> unpackWithCallback arr offs (px4ioStateGetReqConsumer iface)
         , (tag ==? 1829088284) ==> unpackWithCallback arr offs (armingStatusGetReqConsumer iface)
         , (tag ==? 3999854279) ==> unpackWithCallback arr offs (batteryVoltageGetReqConsumer iface)
         ]
vehicleConsumerSender :: forall n s1 s2
                       . (ANat n)
                      => Ref s1 ('Array n ('Stored Uint8))
                      -> Ref s2 ('Stored Uint32)
                      -> VehicleConsumer
vehicleConsumerSender arr offs = VehicleConsumer
  { packedStatusGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3156344986 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlLawGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 301568917 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , rcInputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 296944620 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , userInputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 399143934 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , sensorsOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 26185883 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gyroOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 82693526 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , accelOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1941058076 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , baroOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3344129961 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , lidarliteOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 991289502 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , magOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 143343139 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowIntOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2862321756 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 359304658 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gpsOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3642047882 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlSetpointGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1168870388 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2165647949 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , motorOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2700215595 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attControlDebugGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1652180384 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altControlDebugGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3488192856 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4ioStateGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3679040117 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , armingStatusGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1829088284 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , batteryVoltageGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3999854279 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  }