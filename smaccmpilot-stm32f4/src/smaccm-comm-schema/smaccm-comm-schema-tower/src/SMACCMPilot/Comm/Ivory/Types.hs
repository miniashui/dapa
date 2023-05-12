module SMACCMPilot.Comm.Ivory.Types where
import Ivory.Language
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
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPidConfig as SequenceNumberedPidConfig
import qualified SMACCMPilot.Comm.Ivory.Types.PidConfig as PidConfig
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedThrottleUi as SequenceNumberedThrottleUi
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleUi as ThrottleUi
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedStabConfig as SequenceNumberedStabConfig
import qualified SMACCMPilot.Comm.Ivory.Types.StabConfig as StabConfig
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedTristate as SequenceNumberedTristate
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlModes as SequenceNumberedControlModes
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInput as SequenceNumberedUserInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRgbLedSetting as SequenceNumberedRgbLedSetting
import qualified SMACCMPilot.Comm.Ivory.Types.RgbLedSetting as RgbLedSetting
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedCameraTarget as SequenceNumberedCameraTarget
import qualified SMACCMPilot.Comm.Ivory.Types.CameraTarget as CameraTarget
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRebootReq as SequenceNumberedRebootReq
import qualified SMACCMPilot.Comm.Ivory.Types.RebootReq as RebootReq
import qualified SMACCMPilot.Comm.Ivory.Types.RebootMagic as RebootMagic
typeModules :: [Module]
typeModules =
  [ Heartbeat.heartbeatTypesModule
  , TimeMicros.timeMicrosTypesModule
  , ArmingMode.armingModeTypesModule
  , SequenceNumberedPackedStatus.sequenceNumberedPackedStatusTypesModule
  , SequenceNum.sequenceNumTypesModule
  , PackedStatus.packedStatusTypesModule
  , GpsFix.gpsFixTypesModule
  , Tristate.tristateTypesModule
  , ControlModes.controlModesTypesModule
  , ControlSource.controlSourceTypesModule
  , YawMode.yawModeTypesModule
  , ThrottleMode.throttleModeTypesModule
  , SequenceNumberedControlLaw.sequenceNumberedControlLawTypesModule
  , ControlLaw.controlLawTypesModule
  , SequenceNumberedRcInput.sequenceNumberedRcInputTypesModule
  , RcInput.rcInputTypesModule
  , SequenceNumberedUserInputResult.sequenceNumberedUserInputResultTypesModule
  , UserInputResult.userInputResultTypesModule
  , UserInput.userInputTypesModule
  , SequenceNumberedSensorsResult.sequenceNumberedSensorsResultTypesModule
  , SensorsResult.sensorsResultTypesModule
  , Xyz.xyzTypesModule
  , Quaternion.quaternionTypesModule
  , SequenceNumberedGyroscopeSample.sequenceNumberedGyroscopeSampleTypesModule
  , GyroscopeSample.gyroscopeSampleTypesModule
  , SequenceNumberedAccelerometerSample.sequenceNumberedAccelerometerSampleTypesModule
  , AccelerometerSample.accelerometerSampleTypesModule
  , SequenceNumberedBarometerSample.sequenceNumberedBarometerSampleTypesModule
  , BarometerSample.barometerSampleTypesModule
  , SequenceNumberedLidarliteSample.sequenceNumberedLidarliteSampleTypesModule
  , LidarliteSample.lidarliteSampleTypesModule
  , SequenceNumberedMagnetometerSample.sequenceNumberedMagnetometerSampleTypesModule
  , MagnetometerSample.magnetometerSampleTypesModule
  , SequenceNumberedPx4flowIntegralSample.sequenceNumberedPx4flowIntegralSampleTypesModule
  , Px4flowIntegralSample.px4flowIntegralSampleTypesModule
  , SequenceNumberedPx4flowSample.sequenceNumberedPx4flowSampleTypesModule
  , Px4flowSample.px4flowSampleTypesModule
  , SequenceNumberedPositionSample.sequenceNumberedPositionSampleTypesModule
  , PositionSample.positionSampleTypesModule
  , SequenceNumberedControlSetpoint.sequenceNumberedControlSetpointTypesModule
  , ControlSetpoint.controlSetpointTypesModule
  , SequenceNumberedControlOutput.sequenceNumberedControlOutputTypesModule
  , ControlOutput.controlOutputTypesModule
  , SequenceNumberedQuadcopterMotors.sequenceNumberedQuadcopterMotorsTypesModule
  , QuadcopterMotors.quadcopterMotorsTypesModule
  , SequenceNumberedAttControlDebug.sequenceNumberedAttControlDebugTypesModule
  , AttControlDebug.attControlDebugTypesModule
  , PidState.pidStateTypesModule
  , SequenceNumberedAltControlDebug.sequenceNumberedAltControlDebugTypesModule
  , AltControlDebug.altControlDebugTypesModule
  , SequenceNumberedPx4ioState.sequenceNumberedPx4ioStateTypesModule
  , Px4ioState.px4ioStateTypesModule
  , Px4ioStatus.px4ioStatusTypesModule
  , Px4ioAlarms.px4ioAlarmsTypesModule
  , SequenceNumberedArmingStatus.sequenceNumberedArmingStatusTypesModule
  , ArmingStatus.armingStatusTypesModule
  , SequenceNumberedFloat.sequenceNumberedFloatTypesModule
  , SequenceNumberedPidConfig.sequenceNumberedPidConfigTypesModule
  , PidConfig.pidConfigTypesModule
  , SequenceNumberedThrottleUi.sequenceNumberedThrottleUiTypesModule
  , ThrottleUi.throttleUiTypesModule
  , SequenceNumberedStabConfig.sequenceNumberedStabConfigTypesModule
  , StabConfig.stabConfigTypesModule
  , SequenceNumberedTristate.sequenceNumberedTristateTypesModule
  , SequenceNumberedControlModes.sequenceNumberedControlModesTypesModule
  , SequenceNumberedUserInput.sequenceNumberedUserInputTypesModule
  , SequenceNumberedRgbLedSetting.sequenceNumberedRgbLedSettingTypesModule
  , RgbLedSetting.rgbLedSettingTypesModule
  , SequenceNumberedCameraTarget.sequenceNumberedCameraTargetTypesModule
  , CameraTarget.cameraTargetTypesModule
  , SequenceNumberedRebootReq.sequenceNumberedRebootReqTypesModule
  , RebootReq.rebootReqTypesModule
  , RebootMagic.rebootMagicTypesModule
  ]