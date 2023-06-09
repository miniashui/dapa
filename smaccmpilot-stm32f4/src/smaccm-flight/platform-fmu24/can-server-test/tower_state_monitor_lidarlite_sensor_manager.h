/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_STATE_MONITOR_LIDARLITE_SENSOR_MANAGER_H__
#define __TOWER_STATE_MONITOR_LIDARLITE_SENSOR_MANAGER_H__
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
typedef struct lidarlite_coroutine_continuation {
            uint32_t state;
            struct i2c_transaction_result r0;
            int64_t r1;
            uint8_t deref2;
            uint8_t deref3;
            bool deref17;
            struct i2c_transaction_request local18;
            struct i2c_transaction_result r20;
            int64_t r21;
            uint8_t deref22;
            uint8_t deref23;
            struct i2c_transaction_request local24;
            struct i2c_transaction_result r26;
            int64_t r27;
            uint8_t deref28;
            uint8_t deref29;
            uint8_t deref30;
            uint8_t deref31;
            uint16_t let32;
            int64_t r33;
            struct i2c_transaction_request local4;
            struct i2c_transaction_result r6;
            int64_t r7;
            uint8_t deref8;
            uint8_t deref9;
            struct i2c_transaction_request local10;
            struct i2c_transaction_result r12;
            int64_t r13;
            uint8_t deref14;
            uint8_t deref15;
            uint8_t deref16;
        } lidarlite_coroutine_continuation;
extern struct lidarlite_sample lidarlite_current_sample;
extern int64_t lidarlite_last_response;
extern uint8_t lidarlite_driver_state;
extern struct i2c_transaction_result last_value_5;
extern struct lidarlite_coroutine_continuation lidarlite_coroutine_cont;

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_STATE_MONITOR_LIDARLITE_SENSOR_MANAGER_H__ */
