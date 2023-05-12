{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Native.Interface.Vehicle where
import SMACCMPilot.Comm.Native.Types.Heartbeat
import qualified SMACCMPilot.Comm.Native.Types.Heartbeat as Heartbeat
import SMACCMPilot.Comm.Native.Types.TimeMicros
import qualified SMACCMPilot.Comm.Native.Types.TimeMicros as TimeMicros
import Data.Int
import Data.Int
import SMACCMPilot.Comm.Native.Types.ArmingMode
import qualified SMACCMPilot.Comm.Native.Types.ArmingMode as ArmingMode
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import SMACCMPilot.Comm.Native.Types.SequenceNum
import qualified SMACCMPilot.Comm.Native.Types.SequenceNum as SequenceNum
import Data.Word
import Data.Word
import SMACCMPilot.Comm.Native.Types.PackedStatus
import qualified SMACCMPilot.Comm.Native.Types.PackedStatus as PackedStatus
import SMACCMPilot.Comm.Native.Types.GpsFix
import qualified SMACCMPilot.Comm.Native.Types.GpsFix as GpsFix
import SMACCMPilot.Comm.Native.Types.Tristate
import qualified SMACCMPilot.Comm.Native.Types.Tristate as Tristate
import SMACCMPilot.Comm.Native.Types.ControlModes
import qualified SMACCMPilot.Comm.Native.Types.ControlModes as ControlModes
import SMACCMPilot.Comm.Native.Types.ControlSource
import qualified SMACCMPilot.Comm.Native.Types.ControlSource as ControlSource
import SMACCMPilot.Comm.Native.Types.YawMode
import qualified SMACCMPilot.Comm.Native.Types.YawMode as YawMode
import SMACCMPilot.Comm.Native.Types.ThrottleMode
import qualified SMACCMPilot.Comm.Native.Types.ThrottleMode as ThrottleMode
import SMACCMPilot.Comm.Native.Types.SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import SMACCMPilot.Comm.Native.Types.ControlLaw
import qualified SMACCMPilot.Comm.Native.Types.ControlLaw as ControlLaw
import SMACCMPilot.Comm.Native.Types.SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import SMACCMPilot.Comm.Native.Types.RcInput
import qualified SMACCMPilot.Comm.Native.Types.RcInput as RcInput
import SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import SMACCMPilot.Comm.Native.Types.UserInputResult
import qualified SMACCMPilot.Comm.Native.Types.UserInputResult as UserInputResult
import SMACCMPilot.Comm.Native.Types.UserInput
import qualified SMACCMPilot.Comm.Native.Types.UserInput as UserInput
import SMACCMPilot.Comm.Native.Types.SequenceNumberedSensorsResult
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedSensorsResult as SequenceNumberedSensorsResult
import SMACCMPilot.Comm.Native.Types.SensorsResult
import qualified SMACCMPilot.Comm.Native.Types.SensorsResult as SensorsResult
import SMACCMPilot.Comm.Native.Types.Xyz
import qualified SMACCMPilot.Comm.Native.Types.Xyz as Xyz
import SMACCMPilot.Comm.Native.Types.Quaternion
import qualified SMACCMPilot.Comm.Native.Types.Quaternion as Quaternion
import SMACCMPilot.Comm.Native.Types.SequenceNumberedGyroscopeSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedGyroscopeSample as SequenceNumberedGyroscopeSample
import SMACCMPilot.Comm.Native.Types.GyroscopeSample
import qualified SMACCMPilot.Comm.Native.Types.GyroscopeSample as GyroscopeSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedAccelerometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAccelerometerSample as SequenceNumberedAccelerometerSample
import SMACCMPilot.Comm.Native.Types.AccelerometerSample
import qualified SMACCMPilot.Comm.Native.Types.AccelerometerSample as AccelerometerSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedBarometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedBarometerSample as SequenceNumberedBarometerSample
import SMACCMPilot.Comm.Native.Types.BarometerSample
import qualified SMACCMPilot.Comm.Native.Types.BarometerSample as BarometerSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedLidarliteSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedLidarliteSample as SequenceNumberedLidarliteSample
import SMACCMPilot.Comm.Native.Types.LidarliteSample
import qualified SMACCMPilot.Comm.Native.Types.LidarliteSample as LidarliteSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedMagnetometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedMagnetometerSample as SequenceNumberedMagnetometerSample
import SMACCMPilot.Comm.Native.Types.MagnetometerSample
import qualified SMACCMPilot.Comm.Native.Types.MagnetometerSample as MagnetometerSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowIntegralSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowIntegralSample as SequenceNumberedPx4flowIntegralSample
import SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample as Px4flowIntegralSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowSample as SequenceNumberedPx4flowSample
import SMACCMPilot.Comm.Native.Types.Px4flowSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowSample as Px4flowSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPositionSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPositionSample as SequenceNumberedPositionSample
import SMACCMPilot.Comm.Native.Types.PositionSample
import qualified SMACCMPilot.Comm.Native.Types.PositionSample as PositionSample
import SMACCMPilot.Comm.Native.Types.SequenceNumberedControlSetpoint
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlSetpoint as SequenceNumberedControlSetpoint
import SMACCMPilot.Comm.Native.Types.ControlSetpoint
import qualified SMACCMPilot.Comm.Native.Types.ControlSetpoint as ControlSetpoint
import SMACCMPilot.Comm.Native.Types.SequenceNumberedControlOutput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlOutput as SequenceNumberedControlOutput
import SMACCMPilot.Comm.Native.Types.ControlOutput
import qualified SMACCMPilot.Comm.Native.Types.ControlOutput as ControlOutput
import SMACCMPilot.Comm.Native.Types.SequenceNumberedQuadcopterMotors
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedQuadcopterMotors as SequenceNumberedQuadcopterMotors
import SMACCMPilot.Comm.Native.Types.QuadcopterMotors
import qualified SMACCMPilot.Comm.Native.Types.QuadcopterMotors as QuadcopterMotors
import SMACCMPilot.Comm.Native.Types.SequenceNumberedAttControlDebug
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAttControlDebug as SequenceNumberedAttControlDebug
import SMACCMPilot.Comm.Native.Types.AttControlDebug
import qualified SMACCMPilot.Comm.Native.Types.AttControlDebug as AttControlDebug
import SMACCMPilot.Comm.Native.Types.PidState
import qualified SMACCMPilot.Comm.Native.Types.PidState as PidState
import SMACCMPilot.Comm.Native.Types.SequenceNumberedAltControlDebug
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAltControlDebug as SequenceNumberedAltControlDebug
import SMACCMPilot.Comm.Native.Types.AltControlDebug
import qualified SMACCMPilot.Comm.Native.Types.AltControlDebug as AltControlDebug
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4ioState
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4ioState as SequenceNumberedPx4ioState
import SMACCMPilot.Comm.Native.Types.Px4ioState
import qualified SMACCMPilot.Comm.Native.Types.Px4ioState as Px4ioState
import SMACCMPilot.Comm.Native.Types.Px4ioStatus
import qualified SMACCMPilot.Comm.Native.Types.Px4ioStatus as Px4ioStatus
import SMACCMPilot.Comm.Native.Types.Px4ioAlarms
import qualified SMACCMPilot.Comm.Native.Types.Px4ioAlarms as Px4ioAlarms
import SMACCMPilot.Comm.Native.Types.SequenceNumberedArmingStatus
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedArmingStatus as SequenceNumberedArmingStatus
import SMACCMPilot.Comm.Native.Types.ArmingStatus
import qualified SMACCMPilot.Comm.Native.Types.ArmingStatus as ArmingStatus
import SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat as SequenceNumberedFloat
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
import Data.Aeson (ToJSON,FromJSON)
-- Define Producer schema for Vehicle interface
data VehicleProducer
  = HeartbeatProducer Heartbeat
  | PackedStatusGetRespProducer SequenceNumberedPackedStatus
  | ControlLawGetRespProducer SequenceNumberedControlLaw
  | RcInputGetRespProducer SequenceNumberedRcInput
  | UserInputGetRespProducer SequenceNumberedUserInputResult
  | SensorsOutputGetRespProducer SequenceNumberedSensorsResult
  | GyroOutputGetRespProducer SequenceNumberedGyroscopeSample
  | AccelOutputGetRespProducer SequenceNumberedAccelerometerSample
  | BaroOutputGetRespProducer SequenceNumberedBarometerSample
  | LidarliteOutputGetRespProducer SequenceNumberedLidarliteSample
  | MagOutputGetRespProducer SequenceNumberedMagnetometerSample
  | Px4flowIntOutputGetRespProducer SequenceNumberedPx4flowIntegralSample
  | Px4flowOutputGetRespProducer SequenceNumberedPx4flowSample
  | GpsOutputGetRespProducer SequenceNumberedPositionSample
  | ControlSetpointGetRespProducer SequenceNumberedControlSetpoint
  | ControlOutputGetRespProducer SequenceNumberedControlOutput
  | MotorOutputGetRespProducer SequenceNumberedQuadcopterMotors
  | AttControlDebugGetRespProducer SequenceNumberedAttControlDebug
  | AltControlDebugGetRespProducer SequenceNumberedAltControlDebug
  | Px4ioStateGetRespProducer SequenceNumberedPx4ioState
  | ArmingStatusGetRespProducer SequenceNumberedArmingStatus
  | BatteryVoltageGetRespProducer SequenceNumberedFloat
  deriving (Eq, Show, Data, Typeable, Generic)
putVehicleProducer :: Putter VehicleProducer
putVehicleProducer (HeartbeatProducer m) = putWord32be 1509716040 >> put m
putVehicleProducer (PackedStatusGetRespProducer m) = putWord32be 1735600494 >> put m
putVehicleProducer (ControlLawGetRespProducer m) = putWord32be 3876556457 >> put m
putVehicleProducer (RcInputGetRespProducer m) = putWord32be 1446573644 >> put m
putVehicleProducer (UserInputGetRespProducer m) = putWord32be 1335290396 >> put m
putVehicleProducer (SensorsOutputGetRespProducer m) = putWord32be 1667182401 >> put m
putVehicleProducer (GyroOutputGetRespProducer m) = putWord32be 1997727756 >> put m
putVehicleProducer (AccelOutputGetRespProducer m) = putWord32be 1378612854 >> put m
putVehicleProducer (BaroOutputGetRespProducer m) = putWord32be 1073672794 >> put m
putVehicleProducer (LidarliteOutputGetRespProducer m) = putWord32be 2422378638 >> put m
putVehicleProducer (MagOutputGetRespProducer m) = putWord32be 3699308949 >> put m
putVehicleProducer (Px4flowIntOutputGetRespProducer m) = putWord32be 1473571804 >> put m
putVehicleProducer (Px4flowOutputGetRespProducer m) = putWord32be 4276912125 >> put m
putVehicleProducer (GpsOutputGetRespProducer m) = putWord32be 3319765549 >> put m
putVehicleProducer (ControlSetpointGetRespProducer m) = putWord32be 271213343 >> put m
putVehicleProducer (ControlOutputGetRespProducer m) = putWord32be 2547029879 >> put m
putVehicleProducer (MotorOutputGetRespProducer m) = putWord32be 3888088172 >> put m
putVehicleProducer (AttControlDebugGetRespProducer m) = putWord32be 2996876726 >> put m
putVehicleProducer (AltControlDebugGetRespProducer m) = putWord32be 1833368932 >> put m
putVehicleProducer (Px4ioStateGetRespProducer m) = putWord32be 725470924 >> put m
putVehicleProducer (ArmingStatusGetRespProducer m) = putWord32be 1795869700 >> put m
putVehicleProducer (BatteryVoltageGetRespProducer m) = putWord32be 976778984 >> put m
getVehicleProducer :: Get VehicleProducer
getVehicleProducer = do
  a <- getWord32be
  case a of
    1509716040 -> do
      m <- get
      return (HeartbeatProducer m)
    1735600494 -> do
      m <- get
      return (PackedStatusGetRespProducer m)
    3876556457 -> do
      m <- get
      return (ControlLawGetRespProducer m)
    1446573644 -> do
      m <- get
      return (RcInputGetRespProducer m)
    1335290396 -> do
      m <- get
      return (UserInputGetRespProducer m)
    1667182401 -> do
      m <- get
      return (SensorsOutputGetRespProducer m)
    1997727756 -> do
      m <- get
      return (GyroOutputGetRespProducer m)
    1378612854 -> do
      m <- get
      return (AccelOutputGetRespProducer m)
    1073672794 -> do
      m <- get
      return (BaroOutputGetRespProducer m)
    2422378638 -> do
      m <- get
      return (LidarliteOutputGetRespProducer m)
    3699308949 -> do
      m <- get
      return (MagOutputGetRespProducer m)
    1473571804 -> do
      m <- get
      return (Px4flowIntOutputGetRespProducer m)
    4276912125 -> do
      m <- get
      return (Px4flowOutputGetRespProducer m)
    3319765549 -> do
      m <- get
      return (GpsOutputGetRespProducer m)
    271213343 -> do
      m <- get
      return (ControlSetpointGetRespProducer m)
    2547029879 -> do
      m <- get
      return (ControlOutputGetRespProducer m)
    3888088172 -> do
      m <- get
      return (MotorOutputGetRespProducer m)
    2996876726 -> do
      m <- get
      return (AttControlDebugGetRespProducer m)
    1833368932 -> do
      m <- get
      return (AltControlDebugGetRespProducer m)
    725470924 -> do
      m <- get
      return (Px4ioStateGetRespProducer m)
    1795869700 -> do
      m <- get
      return (ArmingStatusGetRespProducer m)
    976778984 -> do
      m <- get
      return (BatteryVoltageGetRespProducer m)
    _ -> fail "encountered unknown tag in getVehicleProducer"
instance Serialize VehicleProducer where
  put = putVehicleProducer
  get = getVehicleProducer
arbitraryVehicleProducer :: Q.Gen VehicleProducer
arbitraryVehicleProducer =
  Q.oneof [ do
              a <- Q.arbitrary
              return (HeartbeatProducer a)
          , do
              a <- Q.arbitrary
              return (PackedStatusGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ControlLawGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (RcInputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (UserInputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (SensorsOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (GyroOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AccelOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (BaroOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (LidarliteOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (MagOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (Px4flowIntOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (Px4flowOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (GpsOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ControlSetpointGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ControlOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (MotorOutputGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AttControlDebugGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AltControlDebugGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (Px4ioStateGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ArmingStatusGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (BatteryVoltageGetRespProducer a)
          ]
instance Q.Arbitrary VehicleProducer where
  arbitrary = arbitraryVehicleProducer
instance ToJSON VehicleProducer
instance FromJSON VehicleProducer
seqNumGetterVehicleProducer :: VehicleProducer -> SequenceNum
seqNumGetterVehicleProducer (HeartbeatProducer _a) = error "impossible: should not be asking for sequence number of non-attribute"
seqNumGetterVehicleProducer (PackedStatusGetRespProducer _a) = SequenceNumberedPackedStatus.seqnum _a
seqNumGetterVehicleProducer (ControlLawGetRespProducer _a) = SequenceNumberedControlLaw.seqnum _a
seqNumGetterVehicleProducer (RcInputGetRespProducer _a) = SequenceNumberedRcInput.seqnum _a
seqNumGetterVehicleProducer (UserInputGetRespProducer _a) = SequenceNumberedUserInputResult.seqnum _a
seqNumGetterVehicleProducer (SensorsOutputGetRespProducer _a) = SequenceNumberedSensorsResult.seqnum _a
seqNumGetterVehicleProducer (GyroOutputGetRespProducer _a) = SequenceNumberedGyroscopeSample.seqnum _a
seqNumGetterVehicleProducer (AccelOutputGetRespProducer _a) = SequenceNumberedAccelerometerSample.seqnum _a
seqNumGetterVehicleProducer (BaroOutputGetRespProducer _a) = SequenceNumberedBarometerSample.seqnum _a
seqNumGetterVehicleProducer (LidarliteOutputGetRespProducer _a) = SequenceNumberedLidarliteSample.seqnum _a
seqNumGetterVehicleProducer (MagOutputGetRespProducer _a) = SequenceNumberedMagnetometerSample.seqnum _a
seqNumGetterVehicleProducer (Px4flowIntOutputGetRespProducer _a) = SequenceNumberedPx4flowIntegralSample.seqnum _a
seqNumGetterVehicleProducer (Px4flowOutputGetRespProducer _a) = SequenceNumberedPx4flowSample.seqnum _a
seqNumGetterVehicleProducer (GpsOutputGetRespProducer _a) = SequenceNumberedPositionSample.seqnum _a
seqNumGetterVehicleProducer (ControlSetpointGetRespProducer _a) = SequenceNumberedControlSetpoint.seqnum _a
seqNumGetterVehicleProducer (ControlOutputGetRespProducer _a) = SequenceNumberedControlOutput.seqnum _a
seqNumGetterVehicleProducer (MotorOutputGetRespProducer _a) = SequenceNumberedQuadcopterMotors.seqnum _a
seqNumGetterVehicleProducer (AttControlDebugGetRespProducer _a) = SequenceNumberedAttControlDebug.seqnum _a
seqNumGetterVehicleProducer (AltControlDebugGetRespProducer _a) = SequenceNumberedAltControlDebug.seqnum _a
seqNumGetterVehicleProducer (Px4ioStateGetRespProducer _a) = SequenceNumberedPx4ioState.seqnum _a
seqNumGetterVehicleProducer (ArmingStatusGetRespProducer _a) = SequenceNumberedArmingStatus.seqnum _a
seqNumGetterVehicleProducer (BatteryVoltageGetRespProducer _a) = SequenceNumberedFloat.seqnum _a
-- Define Consumer schema for Vehicle interface
data VehicleConsumer
  = PackedStatusGetReqConsumer SequenceNum
  | ControlLawGetReqConsumer SequenceNum
  | RcInputGetReqConsumer SequenceNum
  | UserInputGetReqConsumer SequenceNum
  | SensorsOutputGetReqConsumer SequenceNum
  | GyroOutputGetReqConsumer SequenceNum
  | AccelOutputGetReqConsumer SequenceNum
  | BaroOutputGetReqConsumer SequenceNum
  | LidarliteOutputGetReqConsumer SequenceNum
  | MagOutputGetReqConsumer SequenceNum
  | Px4flowIntOutputGetReqConsumer SequenceNum
  | Px4flowOutputGetReqConsumer SequenceNum
  | GpsOutputGetReqConsumer SequenceNum
  | ControlSetpointGetReqConsumer SequenceNum
  | ControlOutputGetReqConsumer SequenceNum
  | MotorOutputGetReqConsumer SequenceNum
  | AttControlDebugGetReqConsumer SequenceNum
  | AltControlDebugGetReqConsumer SequenceNum
  | Px4ioStateGetReqConsumer SequenceNum
  | ArmingStatusGetReqConsumer SequenceNum
  | BatteryVoltageGetReqConsumer SequenceNum
  deriving (Eq, Show, Data, Typeable, Generic)
putVehicleConsumer :: Putter VehicleConsumer
putVehicleConsumer (PackedStatusGetReqConsumer m) = putWord32be 3156344986 >> put m
putVehicleConsumer (ControlLawGetReqConsumer m) = putWord32be 301568917 >> put m
putVehicleConsumer (RcInputGetReqConsumer m) = putWord32be 296944620 >> put m
putVehicleConsumer (UserInputGetReqConsumer m) = putWord32be 399143934 >> put m
putVehicleConsumer (SensorsOutputGetReqConsumer m) = putWord32be 26185883 >> put m
putVehicleConsumer (GyroOutputGetReqConsumer m) = putWord32be 82693526 >> put m
putVehicleConsumer (AccelOutputGetReqConsumer m) = putWord32be 1941058076 >> put m
putVehicleConsumer (BaroOutputGetReqConsumer m) = putWord32be 3344129961 >> put m
putVehicleConsumer (LidarliteOutputGetReqConsumer m) = putWord32be 991289502 >> put m
putVehicleConsumer (MagOutputGetReqConsumer m) = putWord32be 143343139 >> put m
putVehicleConsumer (Px4flowIntOutputGetReqConsumer m) = putWord32be 2862321756 >> put m
putVehicleConsumer (Px4flowOutputGetReqConsumer m) = putWord32be 359304658 >> put m
putVehicleConsumer (GpsOutputGetReqConsumer m) = putWord32be 3642047882 >> put m
putVehicleConsumer (ControlSetpointGetReqConsumer m) = putWord32be 1168870388 >> put m
putVehicleConsumer (ControlOutputGetReqConsumer m) = putWord32be 2165647949 >> put m
putVehicleConsumer (MotorOutputGetReqConsumer m) = putWord32be 2700215595 >> put m
putVehicleConsumer (AttControlDebugGetReqConsumer m) = putWord32be 1652180384 >> put m
putVehicleConsumer (AltControlDebugGetReqConsumer m) = putWord32be 3488192856 >> put m
putVehicleConsumer (Px4ioStateGetReqConsumer m) = putWord32be 3679040117 >> put m
putVehicleConsumer (ArmingStatusGetReqConsumer m) = putWord32be 1829088284 >> put m
putVehicleConsumer (BatteryVoltageGetReqConsumer m) = putWord32be 3999854279 >> put m
getVehicleConsumer :: Get VehicleConsumer
getVehicleConsumer = do
  a <- getWord32be
  case a of
    3156344986 -> do
      m <- get
      return (PackedStatusGetReqConsumer m)
    301568917 -> do
      m <- get
      return (ControlLawGetReqConsumer m)
    296944620 -> do
      m <- get
      return (RcInputGetReqConsumer m)
    399143934 -> do
      m <- get
      return (UserInputGetReqConsumer m)
    26185883 -> do
      m <- get
      return (SensorsOutputGetReqConsumer m)
    82693526 -> do
      m <- get
      return (GyroOutputGetReqConsumer m)
    1941058076 -> do
      m <- get
      return (AccelOutputGetReqConsumer m)
    3344129961 -> do
      m <- get
      return (BaroOutputGetReqConsumer m)
    991289502 -> do
      m <- get
      return (LidarliteOutputGetReqConsumer m)
    143343139 -> do
      m <- get
      return (MagOutputGetReqConsumer m)
    2862321756 -> do
      m <- get
      return (Px4flowIntOutputGetReqConsumer m)
    359304658 -> do
      m <- get
      return (Px4flowOutputGetReqConsumer m)
    3642047882 -> do
      m <- get
      return (GpsOutputGetReqConsumer m)
    1168870388 -> do
      m <- get
      return (ControlSetpointGetReqConsumer m)
    2165647949 -> do
      m <- get
      return (ControlOutputGetReqConsumer m)
    2700215595 -> do
      m <- get
      return (MotorOutputGetReqConsumer m)
    1652180384 -> do
      m <- get
      return (AttControlDebugGetReqConsumer m)
    3488192856 -> do
      m <- get
      return (AltControlDebugGetReqConsumer m)
    3679040117 -> do
      m <- get
      return (Px4ioStateGetReqConsumer m)
    1829088284 -> do
      m <- get
      return (ArmingStatusGetReqConsumer m)
    3999854279 -> do
      m <- get
      return (BatteryVoltageGetReqConsumer m)
    _ -> fail "encountered unknown tag in getVehicleConsumer"
instance Serialize VehicleConsumer where
  put = putVehicleConsumer
  get = getVehicleConsumer
arbitraryVehicleConsumer :: Q.Gen VehicleConsumer
arbitraryVehicleConsumer =
  Q.oneof [ do
              a <- Q.arbitrary
              return (PackedStatusGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ControlLawGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (RcInputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (UserInputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (SensorsOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (GyroOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AccelOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (BaroOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (LidarliteOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (MagOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (Px4flowIntOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (Px4flowOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (GpsOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ControlSetpointGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ControlOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (MotorOutputGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AttControlDebugGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AltControlDebugGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (Px4ioStateGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ArmingStatusGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (BatteryVoltageGetReqConsumer a)
          ]
instance Q.Arbitrary VehicleConsumer where
  arbitrary = arbitraryVehicleConsumer
instance ToJSON VehicleConsumer
instance FromJSON VehicleConsumer
seqNumGetterVehicleConsumer :: VehicleConsumer -> SequenceNum
seqNumGetterVehicleConsumer (PackedStatusGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (ControlLawGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (RcInputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (UserInputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (SensorsOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (GyroOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (AccelOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (BaroOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (LidarliteOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (MagOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (Px4flowIntOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (Px4flowOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (GpsOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (ControlSetpointGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (ControlOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (MotorOutputGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (AttControlDebugGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (AltControlDebugGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (Px4ioStateGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (ArmingStatusGetReqConsumer _a) = _a
seqNumGetterVehicleConsumer (BatteryVoltageGetReqConsumer _a) = _a