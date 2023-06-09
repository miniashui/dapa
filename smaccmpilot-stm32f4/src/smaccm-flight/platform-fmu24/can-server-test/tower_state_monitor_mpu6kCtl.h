/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_STATE_MONITOR_MPU6KCTL_H__
#define __TOWER_STATE_MONITOR_MPU6KCTL_H__
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
typedef struct mpu6000_continuation {
            uint32_t state;
            struct spi_transaction_request local8;
            struct spi_transaction_result r10;
            struct spi_transaction_request local11;
            struct spi_transaction_result r13;
            struct spi_transaction_request local14;
            struct spi_transaction_result r16;
            struct spi_transaction_request local17;
            struct spi_transaction_result r19;
            struct spi_transaction_request local20;
            struct spi_transaction_result r22;
            struct spi_transaction_result r23;
            int64_t r24;
            uint8_t deref25;
            struct mpu6000_response local26;
            int16_t deref28;
            int16_t deref29;
            int16_t deref30;
            int16_t deref31;
            int16_t deref32;
            int16_t deref33;
            uint16_t deref34;
            float let35;
            struct spi_transaction_request local0;
            struct spi_transaction_result r2;
            struct spi_transaction_request local3;
            struct spi_transaction_result r5;
            uint8_t deref6;
            uint8_t deref7;
        } mpu6000_continuation;
extern uint8_t retries;
extern bool ready;
extern bool transaction_pending;
extern struct gyroscope_sample gyro;
extern struct accelerometer_sample accel;
extern struct spi_transaction_result last_value_2;
extern struct mpu6000_continuation mpu6000_cont;

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_STATE_MONITOR_MPU6KCTL_H__ */
