{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Native.Interface.ControllableVehicle where
import SMACCMPilot.Comm.Native.Types.SequenceNum
import qualified SMACCMPilot.Comm.Native.Types.SequenceNum as SequenceNum
import Data.Word
import Data.Word
import SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat as SequenceNumberedFloat
import SMACCMPilot.Comm.Native.Types.SequenceNumberedPidConfig
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPidConfig as SequenceNumberedPidConfig
import SMACCMPilot.Comm.Native.Types.PidConfig
import qualified SMACCMPilot.Comm.Native.Types.PidConfig as PidConfig
import SMACCMPilot.Comm.Native.Types.SequenceNumberedThrottleUi
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedThrottleUi as SequenceNumberedThrottleUi
import SMACCMPilot.Comm.Native.Types.ThrottleUi
import qualified SMACCMPilot.Comm.Native.Types.ThrottleUi as ThrottleUi
import SMACCMPilot.Comm.Native.Types.SequenceNumberedStabConfig
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedStabConfig as SequenceNumberedStabConfig
import SMACCMPilot.Comm.Native.Types.StabConfig
import qualified SMACCMPilot.Comm.Native.Types.StabConfig as StabConfig
import SMACCMPilot.Comm.Native.Types.SequenceNumberedTristate
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedTristate as SequenceNumberedTristate
import SMACCMPilot.Comm.Native.Types.Tristate
import qualified SMACCMPilot.Comm.Native.Types.Tristate as Tristate
import SMACCMPilot.Comm.Native.Types.SequenceNumberedControlModes
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlModes as SequenceNumberedControlModes
import SMACCMPilot.Comm.Native.Types.ControlModes
import qualified SMACCMPilot.Comm.Native.Types.ControlModes as ControlModes
import SMACCMPilot.Comm.Native.Types.ControlSource
import qualified SMACCMPilot.Comm.Native.Types.ControlSource as ControlSource
import SMACCMPilot.Comm.Native.Types.YawMode
import qualified SMACCMPilot.Comm.Native.Types.YawMode as YawMode
import SMACCMPilot.Comm.Native.Types.ThrottleMode
import qualified SMACCMPilot.Comm.Native.Types.ThrottleMode as ThrottleMode
import SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInput as SequenceNumberedUserInput
import SMACCMPilot.Comm.Native.Types.UserInput
import qualified SMACCMPilot.Comm.Native.Types.UserInput as UserInput
import SMACCMPilot.Comm.Native.Types.SequenceNumberedRgbLedSetting
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRgbLedSetting as SequenceNumberedRgbLedSetting
import SMACCMPilot.Comm.Native.Types.RgbLedSetting
import qualified SMACCMPilot.Comm.Native.Types.RgbLedSetting as RgbLedSetting
import SMACCMPilot.Comm.Native.Types.SequenceNumberedCameraTarget
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedCameraTarget as SequenceNumberedCameraTarget
import SMACCMPilot.Comm.Native.Types.CameraTarget
import qualified SMACCMPilot.Comm.Native.Types.CameraTarget as CameraTarget
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
import SMACCMPilot.Comm.Native.Types.PackedStatus
import qualified SMACCMPilot.Comm.Native.Types.PackedStatus as PackedStatus
import SMACCMPilot.Comm.Native.Types.GpsFix
import qualified SMACCMPilot.Comm.Native.Types.GpsFix as GpsFix
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
import SMACCMPilot.Comm.Native.Types.SequenceNumberedRebootReq
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRebootReq as SequenceNumberedRebootReq
import SMACCMPilot.Comm.Native.Types.RebootReq
import qualified SMACCMPilot.Comm.Native.Types.RebootReq as RebootReq
import SMACCMPilot.Comm.Native.Types.RebootMagic
import qualified SMACCMPilot.Comm.Native.Types.RebootMagic as RebootMagic
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
import Data.Aeson (ToJSON,FromJSON)
-- Define Producer schema for ControllableVehicle interface
data ControllableVehicleProducer
  = RebootReqSetRespProducer SequenceNum
  | NominalThrottleSetRespProducer SequenceNum
  | NominalThrottleGetRespProducer SequenceNumberedFloat
  | AltitudeRatePidSetRespProducer SequenceNum
  | AltitudeRatePidGetRespProducer SequenceNumberedPidConfig
  | AltitudePositionPidSetRespProducer SequenceNum
  | AltitudePositionPidGetRespProducer SequenceNumberedPidConfig
  | ThrottleUiSetRespProducer SequenceNum
  | ThrottleUiGetRespProducer SequenceNumberedThrottleUi
  | AttitudeRollStabSetRespProducer SequenceNum
  | AttitudeRollStabGetRespProducer SequenceNumberedStabConfig
  | AttitudePitchStabSetRespProducer SequenceNum
  | AttitudePitchStabGetRespProducer SequenceNumberedStabConfig
  | YawRatePidSetRespProducer SequenceNum
  | YawRatePidGetRespProducer SequenceNumberedPidConfig
  | YawPositionPidSetRespProducer SequenceNum
  | YawPositionPidGetRespProducer SequenceNumberedPidConfig
  | ArmingRequestSetRespProducer SequenceNum
  | ArmingRequestGetRespProducer SequenceNumberedTristate
  | ControlModesRequestSetRespProducer SequenceNum
  | ControlModesRequestGetRespProducer SequenceNumberedControlModes
  | UserInputRequestSetRespProducer SequenceNum
  | UserInputRequestGetRespProducer SequenceNumberedUserInput
  | RgbLedSetRespProducer SequenceNum
  | RgbLedGetRespProducer SequenceNumberedRgbLedSetting
  | CameraTargetInputGetRespProducer SequenceNumberedCameraTarget
  | HeartbeatProducer Heartbeat
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
putControllableVehicleProducer :: Putter ControllableVehicleProducer
putControllableVehicleProducer (RebootReqSetRespProducer m) = putWord32be 701552887 >> put m
putControllableVehicleProducer (NominalThrottleSetRespProducer m) = putWord32be 2146806488 >> put m
putControllableVehicleProducer (NominalThrottleGetRespProducer m) = putWord32be 4102158390 >> put m
putControllableVehicleProducer (AltitudeRatePidSetRespProducer m) = putWord32be 3131217769 >> put m
putControllableVehicleProducer (AltitudeRatePidGetRespProducer m) = putWord32be 108735486 >> put m
putControllableVehicleProducer (AltitudePositionPidSetRespProducer m) = putWord32be 4175824570 >> put m
putControllableVehicleProducer (AltitudePositionPidGetRespProducer m) = putWord32be 307660055 >> put m
putControllableVehicleProducer (ThrottleUiSetRespProducer m) = putWord32be 798551215 >> put m
putControllableVehicleProducer (ThrottleUiGetRespProducer m) = putWord32be 3742814764 >> put m
putControllableVehicleProducer (AttitudeRollStabSetRespProducer m) = putWord32be 2751362922 >> put m
putControllableVehicleProducer (AttitudeRollStabGetRespProducer m) = putWord32be 4162613527 >> put m
putControllableVehicleProducer (AttitudePitchStabSetRespProducer m) = putWord32be 1716426226 >> put m
putControllableVehicleProducer (AttitudePitchStabGetRespProducer m) = putWord32be 131592019 >> put m
putControllableVehicleProducer (YawRatePidSetRespProducer m) = putWord32be 545391367 >> put m
putControllableVehicleProducer (YawRatePidGetRespProducer m) = putWord32be 522087088 >> put m
putControllableVehicleProducer (YawPositionPidSetRespProducer m) = putWord32be 440628552 >> put m
putControllableVehicleProducer (YawPositionPidGetRespProducer m) = putWord32be 1423245853 >> put m
putControllableVehicleProducer (ArmingRequestSetRespProducer m) = putWord32be 1881494401 >> put m
putControllableVehicleProducer (ArmingRequestGetRespProducer m) = putWord32be 1559632416 >> put m
putControllableVehicleProducer (ControlModesRequestSetRespProducer m) = putWord32be 2681034804 >> put m
putControllableVehicleProducer (ControlModesRequestGetRespProducer m) = putWord32be 141273777 >> put m
putControllableVehicleProducer (UserInputRequestSetRespProducer m) = putWord32be 2039757191 >> put m
putControllableVehicleProducer (UserInputRequestGetRespProducer m) = putWord32be 3292518021 >> put m
putControllableVehicleProducer (RgbLedSetRespProducer m) = putWord32be 2866239093 >> put m
putControllableVehicleProducer (RgbLedGetRespProducer m) = putWord32be 1472267078 >> put m
putControllableVehicleProducer (CameraTargetInputGetRespProducer m) = putWord32be 339771294 >> put m
putControllableVehicleProducer (HeartbeatProducer m) = putWord32be 1509716040 >> put m
putControllableVehicleProducer (PackedStatusGetRespProducer m) = putWord32be 1735600494 >> put m
putControllableVehicleProducer (ControlLawGetRespProducer m) = putWord32be 3876556457 >> put m
putControllableVehicleProducer (RcInputGetRespProducer m) = putWord32be 1446573644 >> put m
putControllableVehicleProducer (UserInputGetRespProducer m) = putWord32be 1335290396 >> put m
putControllableVehicleProducer (SensorsOutputGetRespProducer m) = putWord32be 1667182401 >> put m
putControllableVehicleProducer (GyroOutputGetRespProducer m) = putWord32be 1997727756 >> put m
putControllableVehicleProducer (AccelOutputGetRespProducer m) = putWord32be 1378612854 >> put m
putControllableVehicleProducer (BaroOutputGetRespProducer m) = putWord32be 1073672794 >> put m
putControllableVehicleProducer (LidarliteOutputGetRespProducer m) = putWord32be 2422378638 >> put m
putControllableVehicleProducer (MagOutputGetRespProducer m) = putWord32be 3699308949 >> put m
putControllableVehicleProducer (Px4flowIntOutputGetRespProducer m) = putWord32be 1473571804 >> put m
putControllableVehicleProducer (Px4flowOutputGetRespProducer m) = putWord32be 4276912125 >> put m
putControllableVehicleProducer (GpsOutputGetRespProducer m) = putWord32be 3319765549 >> put m
putControllableVehicleProducer (ControlSetpointGetRespProducer m) = putWord32be 271213343 >> put m
putControllableVehicleProducer (ControlOutputGetRespProducer m) = putWord32be 2547029879 >> put m
putControllableVehicleProducer (MotorOutputGetRespProducer m) = putWord32be 3888088172 >> put m
putControllableVehicleProducer (AttControlDebugGetRespProducer m) = putWord32be 2996876726 >> put m
putControllableVehicleProducer (AltControlDebugGetRespProducer m) = putWord32be 1833368932 >> put m
putControllableVehicleProducer (Px4ioStateGetRespProducer m) = putWord32be 725470924 >> put m
putControllableVehicleProducer (ArmingStatusGetRespProducer m) = putWord32be 1795869700 >> put m
putControllableVehicleProducer (BatteryVoltageGetRespProducer m) = putWord32be 976778984 >> put m
getControllableVehicleProducer :: Get ControllableVehicleProducer
getControllableVehicleProducer = do
  a <- getWord32be
  case a of
    701552887 -> do
      m <- get
      return (RebootReqSetRespProducer m)
    2146806488 -> do
      m <- get
      return (NominalThrottleSetRespProducer m)
    4102158390 -> do
      m <- get
      return (NominalThrottleGetRespProducer m)
    3131217769 -> do
      m <- get
      return (AltitudeRatePidSetRespProducer m)
    108735486 -> do
      m <- get
      return (AltitudeRatePidGetRespProducer m)
    4175824570 -> do
      m <- get
      return (AltitudePositionPidSetRespProducer m)
    307660055 -> do
      m <- get
      return (AltitudePositionPidGetRespProducer m)
    798551215 -> do
      m <- get
      return (ThrottleUiSetRespProducer m)
    3742814764 -> do
      m <- get
      return (ThrottleUiGetRespProducer m)
    2751362922 -> do
      m <- get
      return (AttitudeRollStabSetRespProducer m)
    4162613527 -> do
      m <- get
      return (AttitudeRollStabGetRespProducer m)
    1716426226 -> do
      m <- get
      return (AttitudePitchStabSetRespProducer m)
    131592019 -> do
      m <- get
      return (AttitudePitchStabGetRespProducer m)
    545391367 -> do
      m <- get
      return (YawRatePidSetRespProducer m)
    522087088 -> do
      m <- get
      return (YawRatePidGetRespProducer m)
    440628552 -> do
      m <- get
      return (YawPositionPidSetRespProducer m)
    1423245853 -> do
      m <- get
      return (YawPositionPidGetRespProducer m)
    1881494401 -> do
      m <- get
      return (ArmingRequestSetRespProducer m)
    1559632416 -> do
      m <- get
      return (ArmingRequestGetRespProducer m)
    2681034804 -> do
      m <- get
      return (ControlModesRequestSetRespProducer m)
    141273777 -> do
      m <- get
      return (ControlModesRequestGetRespProducer m)
    2039757191 -> do
      m <- get
      return (UserInputRequestSetRespProducer m)
    3292518021 -> do
      m <- get
      return (UserInputRequestGetRespProducer m)
    2866239093 -> do
      m <- get
      return (RgbLedSetRespProducer m)
    1472267078 -> do
      m <- get
      return (RgbLedGetRespProducer m)
    339771294 -> do
      m <- get
      return (CameraTargetInputGetRespProducer m)
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
    _ -> fail "encountered unknown tag in getControllableVehicleProducer"
instance Serialize ControllableVehicleProducer where
  put = putControllableVehicleProducer
  get = getControllableVehicleProducer
arbitraryControllableVehicleProducer :: Q.Gen ControllableVehicleProducer
arbitraryControllableVehicleProducer =
  Q.oneof [ do
              a <- Q.arbitrary
              return (RebootReqSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (NominalThrottleSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (NominalThrottleGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AltitudeRatePidSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AltitudeRatePidGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AltitudePositionPidSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AltitudePositionPidGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ThrottleUiSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ThrottleUiGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AttitudeRollStabSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AttitudeRollStabGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AttitudePitchStabSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (AttitudePitchStabGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (YawRatePidSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (YawRatePidGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (YawPositionPidSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (YawPositionPidGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ArmingRequestSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ArmingRequestGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ControlModesRequestSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (ControlModesRequestGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (UserInputRequestSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (UserInputRequestGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (RgbLedSetRespProducer a)
          , do
              a <- Q.arbitrary
              return (RgbLedGetRespProducer a)
          , do
              a <- Q.arbitrary
              return (CameraTargetInputGetRespProducer a)
          , do
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
instance Q.Arbitrary ControllableVehicleProducer where
  arbitrary = arbitraryControllableVehicleProducer
instance ToJSON ControllableVehicleProducer
instance FromJSON ControllableVehicleProducer
seqNumGetterControllableVehicleProducer :: ControllableVehicleProducer -> SequenceNum
seqNumGetterControllableVehicleProducer (RebootReqSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (NominalThrottleSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (NominalThrottleGetRespProducer _a) = SequenceNumberedFloat.seqnum _a
seqNumGetterControllableVehicleProducer (AltitudeRatePidSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (AltitudeRatePidGetRespProducer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleProducer (AltitudePositionPidSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (AltitudePositionPidGetRespProducer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleProducer (ThrottleUiSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (ThrottleUiGetRespProducer _a) = SequenceNumberedThrottleUi.seqnum _a
seqNumGetterControllableVehicleProducer (AttitudeRollStabSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (AttitudeRollStabGetRespProducer _a) = SequenceNumberedStabConfig.seqnum _a
seqNumGetterControllableVehicleProducer (AttitudePitchStabSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (AttitudePitchStabGetRespProducer _a) = SequenceNumberedStabConfig.seqnum _a
seqNumGetterControllableVehicleProducer (YawRatePidSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (YawRatePidGetRespProducer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleProducer (YawPositionPidSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (YawPositionPidGetRespProducer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleProducer (ArmingRequestSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (ArmingRequestGetRespProducer _a) = SequenceNumberedTristate.seqnum _a
seqNumGetterControllableVehicleProducer (ControlModesRequestSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (ControlModesRequestGetRespProducer _a) = SequenceNumberedControlModes.seqnum _a
seqNumGetterControllableVehicleProducer (UserInputRequestSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (UserInputRequestGetRespProducer _a) = SequenceNumberedUserInput.seqnum _a
seqNumGetterControllableVehicleProducer (RgbLedSetRespProducer _a) = _a
seqNumGetterControllableVehicleProducer (RgbLedGetRespProducer _a) = SequenceNumberedRgbLedSetting.seqnum _a
seqNumGetterControllableVehicleProducer (CameraTargetInputGetRespProducer _a) = SequenceNumberedCameraTarget.seqnum _a
seqNumGetterControllableVehicleProducer (HeartbeatProducer _a) = error "impossible: should not be asking for sequence number of non-attribute"
seqNumGetterControllableVehicleProducer (PackedStatusGetRespProducer _a) = SequenceNumberedPackedStatus.seqnum _a
seqNumGetterControllableVehicleProducer (ControlLawGetRespProducer _a) = SequenceNumberedControlLaw.seqnum _a
seqNumGetterControllableVehicleProducer (RcInputGetRespProducer _a) = SequenceNumberedRcInput.seqnum _a
seqNumGetterControllableVehicleProducer (UserInputGetRespProducer _a) = SequenceNumberedUserInputResult.seqnum _a
seqNumGetterControllableVehicleProducer (SensorsOutputGetRespProducer _a) = SequenceNumberedSensorsResult.seqnum _a
seqNumGetterControllableVehicleProducer (GyroOutputGetRespProducer _a) = SequenceNumberedGyroscopeSample.seqnum _a
seqNumGetterControllableVehicleProducer (AccelOutputGetRespProducer _a) = SequenceNumberedAccelerometerSample.seqnum _a
seqNumGetterControllableVehicleProducer (BaroOutputGetRespProducer _a) = SequenceNumberedBarometerSample.seqnum _a
seqNumGetterControllableVehicleProducer (LidarliteOutputGetRespProducer _a) = SequenceNumberedLidarliteSample.seqnum _a
seqNumGetterControllableVehicleProducer (MagOutputGetRespProducer _a) = SequenceNumberedMagnetometerSample.seqnum _a
seqNumGetterControllableVehicleProducer (Px4flowIntOutputGetRespProducer _a) = SequenceNumberedPx4flowIntegralSample.seqnum _a
seqNumGetterControllableVehicleProducer (Px4flowOutputGetRespProducer _a) = SequenceNumberedPx4flowSample.seqnum _a
seqNumGetterControllableVehicleProducer (GpsOutputGetRespProducer _a) = SequenceNumberedPositionSample.seqnum _a
seqNumGetterControllableVehicleProducer (ControlSetpointGetRespProducer _a) = SequenceNumberedControlSetpoint.seqnum _a
seqNumGetterControllableVehicleProducer (ControlOutputGetRespProducer _a) = SequenceNumberedControlOutput.seqnum _a
seqNumGetterControllableVehicleProducer (MotorOutputGetRespProducer _a) = SequenceNumberedQuadcopterMotors.seqnum _a
seqNumGetterControllableVehicleProducer (AttControlDebugGetRespProducer _a) = SequenceNumberedAttControlDebug.seqnum _a
seqNumGetterControllableVehicleProducer (AltControlDebugGetRespProducer _a) = SequenceNumberedAltControlDebug.seqnum _a
seqNumGetterControllableVehicleProducer (Px4ioStateGetRespProducer _a) = SequenceNumberedPx4ioState.seqnum _a
seqNumGetterControllableVehicleProducer (ArmingStatusGetRespProducer _a) = SequenceNumberedArmingStatus.seqnum _a
seqNumGetterControllableVehicleProducer (BatteryVoltageGetRespProducer _a) = SequenceNumberedFloat.seqnum _a
-- Define Consumer schema for ControllableVehicle interface
data ControllableVehicleConsumer
  = RebootReqSetReqConsumer SequenceNumberedRebootReq
  | NominalThrottleSetReqConsumer SequenceNumberedFloat
  | NominalThrottleGetReqConsumer SequenceNum
  | AltitudeRatePidSetReqConsumer SequenceNumberedPidConfig
  | AltitudeRatePidGetReqConsumer SequenceNum
  | AltitudePositionPidSetReqConsumer SequenceNumberedPidConfig
  | AltitudePositionPidGetReqConsumer SequenceNum
  | ThrottleUiSetReqConsumer SequenceNumberedThrottleUi
  | ThrottleUiGetReqConsumer SequenceNum
  | AttitudeRollStabSetReqConsumer SequenceNumberedStabConfig
  | AttitudeRollStabGetReqConsumer SequenceNum
  | AttitudePitchStabSetReqConsumer SequenceNumberedStabConfig
  | AttitudePitchStabGetReqConsumer SequenceNum
  | YawRatePidSetReqConsumer SequenceNumberedPidConfig
  | YawRatePidGetReqConsumer SequenceNum
  | YawPositionPidSetReqConsumer SequenceNumberedPidConfig
  | YawPositionPidGetReqConsumer SequenceNum
  | ArmingRequestSetReqConsumer SequenceNumberedTristate
  | ArmingRequestGetReqConsumer SequenceNum
  | ControlModesRequestSetReqConsumer SequenceNumberedControlModes
  | ControlModesRequestGetReqConsumer SequenceNum
  | UserInputRequestSetReqConsumer SequenceNumberedUserInput
  | UserInputRequestGetReqConsumer SequenceNum
  | RgbLedSetReqConsumer SequenceNumberedRgbLedSetting
  | RgbLedGetReqConsumer SequenceNum
  | CameraTargetInputGetReqConsumer SequenceNum
  | PackedStatusGetReqConsumer SequenceNum
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
putControllableVehicleConsumer :: Putter ControllableVehicleConsumer
putControllableVehicleConsumer (RebootReqSetReqConsumer m) = putWord32be 2653177294 >> put m
putControllableVehicleConsumer (NominalThrottleSetReqConsumer m) = putWord32be 902408967 >> put m
putControllableVehicleConsumer (NominalThrottleGetReqConsumer m) = putWord32be 900547145 >> put m
putControllableVehicleConsumer (AltitudeRatePidSetReqConsumer m) = putWord32be 2277441295 >> put m
putControllableVehicleConsumer (AltitudeRatePidGetReqConsumer m) = putWord32be 875324090 >> put m
putControllableVehicleConsumer (AltitudePositionPidSetReqConsumer m) = putWord32be 1796873384 >> put m
putControllableVehicleConsumer (AltitudePositionPidGetReqConsumer m) = putWord32be 2977840359 >> put m
putControllableVehicleConsumer (ThrottleUiSetReqConsumer m) = putWord32be 2223647017 >> put m
putControllableVehicleConsumer (ThrottleUiGetReqConsumer m) = putWord32be 1993123068 >> put m
putControllableVehicleConsumer (AttitudeRollStabSetReqConsumer m) = putWord32be 1965596194 >> put m
putControllableVehicleConsumer (AttitudeRollStabGetReqConsumer m) = putWord32be 3014795959 >> put m
putControllableVehicleConsumer (AttitudePitchStabSetReqConsumer m) = putWord32be 1981014966 >> put m
putControllableVehicleConsumer (AttitudePitchStabGetReqConsumer m) = putWord32be 1987435407 >> put m
putControllableVehicleConsumer (YawRatePidSetReqConsumer m) = putWord32be 358476597 >> put m
putControllableVehicleConsumer (YawRatePidGetReqConsumer m) = putWord32be 2269087216 >> put m
putControllableVehicleConsumer (YawPositionPidSetReqConsumer m) = putWord32be 2133908270 >> put m
putControllableVehicleConsumer (YawPositionPidGetReqConsumer m) = putWord32be 3220216729 >> put m
putControllableVehicleConsumer (ArmingRequestSetReqConsumer m) = putWord32be 734318043 >> put m
putControllableVehicleConsumer (ArmingRequestGetReqConsumer m) = putWord32be 2927838066 >> put m
putControllableVehicleConsumer (ControlModesRequestSetReqConsumer m) = putWord32be 4125087790 >> put m
putControllableVehicleConsumer (ControlModesRequestGetReqConsumer m) = putWord32be 2571639185 >> put m
putControllableVehicleConsumer (UserInputRequestSetReqConsumer m) = putWord32be 1007683408 >> put m
putControllableVehicleConsumer (UserInputRequestGetReqConsumer m) = putWord32be 3283842892 >> put m
putControllableVehicleConsumer (RgbLedSetReqConsumer m) = putWord32be 2121216375 >> put m
putControllableVehicleConsumer (RgbLedGetReqConsumer m) = putWord32be 58884490 >> put m
putControllableVehicleConsumer (CameraTargetInputGetReqConsumer m) = putWord32be 3442022133 >> put m
putControllableVehicleConsumer (PackedStatusGetReqConsumer m) = putWord32be 3156344986 >> put m
putControllableVehicleConsumer (ControlLawGetReqConsumer m) = putWord32be 301568917 >> put m
putControllableVehicleConsumer (RcInputGetReqConsumer m) = putWord32be 296944620 >> put m
putControllableVehicleConsumer (UserInputGetReqConsumer m) = putWord32be 399143934 >> put m
putControllableVehicleConsumer (SensorsOutputGetReqConsumer m) = putWord32be 26185883 >> put m
putControllableVehicleConsumer (GyroOutputGetReqConsumer m) = putWord32be 82693526 >> put m
putControllableVehicleConsumer (AccelOutputGetReqConsumer m) = putWord32be 1941058076 >> put m
putControllableVehicleConsumer (BaroOutputGetReqConsumer m) = putWord32be 3344129961 >> put m
putControllableVehicleConsumer (LidarliteOutputGetReqConsumer m) = putWord32be 991289502 >> put m
putControllableVehicleConsumer (MagOutputGetReqConsumer m) = putWord32be 143343139 >> put m
putControllableVehicleConsumer (Px4flowIntOutputGetReqConsumer m) = putWord32be 2862321756 >> put m
putControllableVehicleConsumer (Px4flowOutputGetReqConsumer m) = putWord32be 359304658 >> put m
putControllableVehicleConsumer (GpsOutputGetReqConsumer m) = putWord32be 3642047882 >> put m
putControllableVehicleConsumer (ControlSetpointGetReqConsumer m) = putWord32be 1168870388 >> put m
putControllableVehicleConsumer (ControlOutputGetReqConsumer m) = putWord32be 2165647949 >> put m
putControllableVehicleConsumer (MotorOutputGetReqConsumer m) = putWord32be 2700215595 >> put m
putControllableVehicleConsumer (AttControlDebugGetReqConsumer m) = putWord32be 1652180384 >> put m
putControllableVehicleConsumer (AltControlDebugGetReqConsumer m) = putWord32be 3488192856 >> put m
putControllableVehicleConsumer (Px4ioStateGetReqConsumer m) = putWord32be 3679040117 >> put m
putControllableVehicleConsumer (ArmingStatusGetReqConsumer m) = putWord32be 1829088284 >> put m
putControllableVehicleConsumer (BatteryVoltageGetReqConsumer m) = putWord32be 3999854279 >> put m
getControllableVehicleConsumer :: Get ControllableVehicleConsumer
getControllableVehicleConsumer = do
  a <- getWord32be
  case a of
    2653177294 -> do
      m <- get
      return (RebootReqSetReqConsumer m)
    902408967 -> do
      m <- get
      return (NominalThrottleSetReqConsumer m)
    900547145 -> do
      m <- get
      return (NominalThrottleGetReqConsumer m)
    2277441295 -> do
      m <- get
      return (AltitudeRatePidSetReqConsumer m)
    875324090 -> do
      m <- get
      return (AltitudeRatePidGetReqConsumer m)
    1796873384 -> do
      m <- get
      return (AltitudePositionPidSetReqConsumer m)
    2977840359 -> do
      m <- get
      return (AltitudePositionPidGetReqConsumer m)
    2223647017 -> do
      m <- get
      return (ThrottleUiSetReqConsumer m)
    1993123068 -> do
      m <- get
      return (ThrottleUiGetReqConsumer m)
    1965596194 -> do
      m <- get
      return (AttitudeRollStabSetReqConsumer m)
    3014795959 -> do
      m <- get
      return (AttitudeRollStabGetReqConsumer m)
    1981014966 -> do
      m <- get
      return (AttitudePitchStabSetReqConsumer m)
    1987435407 -> do
      m <- get
      return (AttitudePitchStabGetReqConsumer m)
    358476597 -> do
      m <- get
      return (YawRatePidSetReqConsumer m)
    2269087216 -> do
      m <- get
      return (YawRatePidGetReqConsumer m)
    2133908270 -> do
      m <- get
      return (YawPositionPidSetReqConsumer m)
    3220216729 -> do
      m <- get
      return (YawPositionPidGetReqConsumer m)
    734318043 -> do
      m <- get
      return (ArmingRequestSetReqConsumer m)
    2927838066 -> do
      m <- get
      return (ArmingRequestGetReqConsumer m)
    4125087790 -> do
      m <- get
      return (ControlModesRequestSetReqConsumer m)
    2571639185 -> do
      m <- get
      return (ControlModesRequestGetReqConsumer m)
    1007683408 -> do
      m <- get
      return (UserInputRequestSetReqConsumer m)
    3283842892 -> do
      m <- get
      return (UserInputRequestGetReqConsumer m)
    2121216375 -> do
      m <- get
      return (RgbLedSetReqConsumer m)
    58884490 -> do
      m <- get
      return (RgbLedGetReqConsumer m)
    3442022133 -> do
      m <- get
      return (CameraTargetInputGetReqConsumer m)
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
    _ -> fail "encountered unknown tag in getControllableVehicleConsumer"
instance Serialize ControllableVehicleConsumer where
  put = putControllableVehicleConsumer
  get = getControllableVehicleConsumer
arbitraryControllableVehicleConsumer :: Q.Gen ControllableVehicleConsumer
arbitraryControllableVehicleConsumer =
  Q.oneof [ do
              a <- Q.arbitrary
              return (RebootReqSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (NominalThrottleSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (NominalThrottleGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AltitudeRatePidSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AltitudeRatePidGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AltitudePositionPidSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AltitudePositionPidGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ThrottleUiSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ThrottleUiGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AttitudeRollStabSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AttitudeRollStabGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AttitudePitchStabSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (AttitudePitchStabGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (YawRatePidSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (YawRatePidGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (YawPositionPidSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (YawPositionPidGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ArmingRequestSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ArmingRequestGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ControlModesRequestSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (ControlModesRequestGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (UserInputRequestSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (UserInputRequestGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (RgbLedSetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (RgbLedGetReqConsumer a)
          , do
              a <- Q.arbitrary
              return (CameraTargetInputGetReqConsumer a)
          , do
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
instance Q.Arbitrary ControllableVehicleConsumer where
  arbitrary = arbitraryControllableVehicleConsumer
instance ToJSON ControllableVehicleConsumer
instance FromJSON ControllableVehicleConsumer
seqNumGetterControllableVehicleConsumer :: ControllableVehicleConsumer -> SequenceNum
seqNumGetterControllableVehicleConsumer (RebootReqSetReqConsumer _a) = SequenceNumberedRebootReq.seqnum _a
seqNumGetterControllableVehicleConsumer (NominalThrottleSetReqConsumer _a) = SequenceNumberedFloat.seqnum _a
seqNumGetterControllableVehicleConsumer (NominalThrottleGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AltitudeRatePidSetReqConsumer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (AltitudeRatePidGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AltitudePositionPidSetReqConsumer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (AltitudePositionPidGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ThrottleUiSetReqConsumer _a) = SequenceNumberedThrottleUi.seqnum _a
seqNumGetterControllableVehicleConsumer (ThrottleUiGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AttitudeRollStabSetReqConsumer _a) = SequenceNumberedStabConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (AttitudeRollStabGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AttitudePitchStabSetReqConsumer _a) = SequenceNumberedStabConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (AttitudePitchStabGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (YawRatePidSetReqConsumer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (YawRatePidGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (YawPositionPidSetReqConsumer _a) = SequenceNumberedPidConfig.seqnum _a
seqNumGetterControllableVehicleConsumer (YawPositionPidGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ArmingRequestSetReqConsumer _a) = SequenceNumberedTristate.seqnum _a
seqNumGetterControllableVehicleConsumer (ArmingRequestGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ControlModesRequestSetReqConsumer _a) = SequenceNumberedControlModes.seqnum _a
seqNumGetterControllableVehicleConsumer (ControlModesRequestGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (UserInputRequestSetReqConsumer _a) = SequenceNumberedUserInput.seqnum _a
seqNumGetterControllableVehicleConsumer (UserInputRequestGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (RgbLedSetReqConsumer _a) = SequenceNumberedRgbLedSetting.seqnum _a
seqNumGetterControllableVehicleConsumer (RgbLedGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (CameraTargetInputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (PackedStatusGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ControlLawGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (RcInputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (UserInputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (SensorsOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (GyroOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AccelOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (BaroOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (LidarliteOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (MagOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (Px4flowIntOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (Px4flowOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (GpsOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ControlSetpointGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ControlOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (MotorOutputGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AttControlDebugGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (AltControlDebugGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (Px4ioStateGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (ArmingStatusGetReqConsumer _a) = _a
seqNumGetterControllableVehicleConsumer (BatteryVoltageGetReqConsumer _a) = _a