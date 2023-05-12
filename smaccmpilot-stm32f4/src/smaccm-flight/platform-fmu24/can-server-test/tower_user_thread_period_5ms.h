/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_PERIOD_5MS_H__
#define __TOWER_USER_THREAD_PERIOD_5MS_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "canDriverTypes.h"
#include "heartbeat_types.h"
#include "time_micros_types.h"
#include "arming_mode_types.h"
#include "sequence_numbered_packed_status_types.h"
#include "sequence_num_types.h"
#include "packed_status_types.h"
#include "gps_fix_types.h"
#include "tristate_types.h"
#include "control_modes_types.h"
#include "control_source_types.h"
#include "yaw_mode_types.h"
#include "throttle_mode_types.h"
#include "sequence_numbered_control_law_types.h"
#include "control_law_types.h"
#include "sequence_numbered_rc_input_types.h"
#include "rc_input_types.h"
#include "sequence_numbered_user_input_result_types.h"
#include "user_input_result_types.h"
#include "user_input_types.h"
#include "sequence_numbered_sensors_result_types.h"
#include "sensors_result_types.h"
#include "xyz_types.h"
#include "quaternion_types.h"
#include "sequence_numbered_gyroscope_sample_types.h"
#include "gyroscope_sample_types.h"
#include "sequence_numbered_accelerometer_sample_types.h"
#include "accelerometer_sample_types.h"
#include "sequence_numbered_barometer_sample_types.h"
#include "barometer_sample_types.h"
#include "sequence_numbered_lidarlite_sample_types.h"
#include "lidarlite_sample_types.h"
#include "sequence_numbered_magnetometer_sample_types.h"
#include "magnetometer_sample_types.h"
#include "sequence_numbered_px4flow_integral_sample_types.h"
#include "px4flow_integral_sample_types.h"
#include "sequence_numbered_px4flow_sample_types.h"
#include "px4flow_sample_types.h"
#include "sequence_numbered_position_sample_types.h"
#include "position_sample_types.h"
#include "sequence_numbered_control_setpoint_types.h"
#include "control_setpoint_types.h"
#include "sequence_numbered_control_output_types.h"
#include "control_output_types.h"
#include "sequence_numbered_quadcopter_motors_types.h"
#include "quadcopter_motors_types.h"
#include "sequence_numbered_att_control_debug_types.h"
#include "att_control_debug_types.h"
#include "pid_state_types.h"
#include "sequence_numbered_alt_control_debug_types.h"
#include "alt_control_debug_types.h"
#include "sequence_numbered_px4io_state_types.h"
#include "px4io_state_types.h"
#include "px4io_status_types.h"
#include "px4io_alarms_types.h"
#include "sequence_numbered_arming_status_types.h"
#include "arming_status_types.h"
#include "sequence_numbered_float_types.h"
#include "sequence_numbered_pid_config_types.h"
#include "pid_config_types.h"
#include "sequence_numbered_throttle_ui_types.h"
#include "throttle_ui_types.h"
#include "sequence_numbered_stab_config_types.h"
#include "stab_config_types.h"
#include "sequence_numbered_tristate_types.h"
#include "sequence_numbered_control_modes_types.h"
#include "sequence_numbered_user_input_types.h"
#include "sequence_numbered_rgb_led_setting_types.h"
#include "rgb_led_setting_types.h"
#include "sequence_numbered_camera_target_types.h"
#include "camera_target_types.h"
#include "sequence_numbered_reboot_req_types.h"
#include "reboot_req_types.h"
#include "reboot_magic_types.h"
#include "ivory_serialize.h"
#include "gps_common.h"
#include "spiDriverTypes.h"
#include "mpu6000_response_types.h"
#include "ms5611_types.h"
#include "i2cTowerTypes.h"
#include "attitude_filter.h"
#include "tower_state_monitor_mpu6kCtl.h"
#include "tower_state_monitor_spi1_scheduler.h"
#include "tower_state_monitor_spi1PeripheralDriver.h"
#include "tower_state_monitor_detectMotion.h"
#include "tower_state_monitor_gyro_output_attrProxy.h"
#include "tower_state_monitor_gyro_output_attrServer.h"
#include "tower_state_monitor_att_est_sensor_fusion.h"
#include "tower_state_monitor_sensor_fusion_proxy.h"
#include "tower_state_monitor_sensors_output_attrServer.h"
#include "tower_state_monitor_motion_light_debug.h"
#include "tower_state_monitor_rgb_led_attrServer.h"
#include "tower_state_monitor_rgbled.h"
#include "tower_state_monitor_i2c2PeripheralDriver.h"
#include "tower_state_monitor_accel_output_attrProxy.h"
#include "tower_state_monitor_accel_output_attrServer.h"
#include "tower_gen_thread_period_5ms.h"
#include "tower_time.h"
void callback_i2c_response_thread_period_5ms(const struct i2c_transaction_result *n_var0);
void callback_set_thread_period_5ms(const struct rgb_led_setting *n_var0);
void callback_i2c2_request_thread_period_5ms(const struct i2c_transaction_request *n_var0);
void callback_new_state_thread_period_5ms(const struct AhrsMlkf *n_var0);
void callback_save_last_gyro_thread_period_5ms(const struct gyroscope_sample *n_var0);
void callback_save_last_accel_thread_period_5ms(const struct accelerometer_sample *n_var0);
void callback_att_est_motion_thread_period_5ms(const bool *n_var0);
void callback_att_est_gyro_thread_period_5ms(const struct gyroscope_sample *n_var0);
void callback_att_est_accel_thread_period_5ms(const struct accelerometer_sample *n_var0);
void callback_write_gyro_output_attr_thread_period_5ms(const struct gyroscope_sample *n_var0);
void callback_write_accel_output_attr_thread_period_5ms(const struct accelerometer_sample *n_var0);
void callback_motion_light_debug_2_thread_period_5ms(const bool *n_var0);
void callback_detectMotion_2_accel_thread_period_5ms(const struct accelerometer_sample *n_var0);
void callback_detectMotion_2_gyro_thread_period_5ms(const struct gyroscope_sample *n_var0);
void callback_spi1_scheduler_mpu6000_thread_period_5ms(const struct spi_transaction_request *n_var0);
void callback_period_thread_period_5ms(const int64_t *n_var0);
void callback_request_4_thread_period_5ms(const struct spi_transaction_request *n_var0);
void callback_accel_output_attr_update_thread_period_5ms(const struct accelerometer_sample *n_var0);
void callback_gyro_output_attr_update_thread_period_5ms(const struct gyroscope_sample *n_var0);
void callback_sensors_output_attr_update_thread_period_5ms(const struct sensors_result *n_var0);
void callback_rgb_led_attr_update_thread_period_5ms(const struct rgb_led_setting *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_PERIOD_5MS_H__ */
