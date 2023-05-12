/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_STATE_MONITOR_LSM303DSENSORMANAGER_H__
#define __TOWER_STATE_MONITOR_LSM303DSENSORMANAGER_H__
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
typedef struct lsm303d_coroutine_continuation {
            uint32_t state;
            struct spi_transaction_request local0;
            struct spi_transaction_result r2;
            uint8_t deref3;
            uint8_t deref4;
            struct spi_transaction_request local5;
            struct spi_transaction_result r7;
            uint8_t deref8;
            uint8_t deref9;
            struct spi_transaction_request local10;
            struct spi_transaction_result r12;
            uint8_t deref13;
            struct spi_transaction_request local14;
            struct spi_transaction_result r16;
            uint8_t deref17;
            uint8_t deref18;
            struct spi_transaction_request local19;
            struct spi_transaction_result r21;
            uint8_t deref22;
            struct spi_transaction_request local23;
            struct spi_transaction_result r25;
            uint8_t deref26;
            uint8_t deref27;
            struct spi_transaction_request local28;
            struct spi_transaction_result r30;
            uint8_t deref31;
            struct spi_transaction_request local32;
            struct spi_transaction_result r34;
            uint8_t deref35;
            uint8_t deref36;
            struct spi_transaction_request local37;
            struct spi_transaction_result r39;
            uint8_t deref40;
            struct spi_transaction_request local41;
            struct spi_transaction_result r43;
            uint8_t deref44;
            struct spi_transaction_request local45;
            struct spi_transaction_result r47;
            uint8_t deref48;
            struct spi_transaction_request local49;
            struct spi_transaction_result r51;
            uint8_t deref52;
            struct spi_transaction_request local53;
            struct spi_transaction_result r55;
            uint8_t deref56;
            struct spi_transaction_request local57;
            struct spi_transaction_result r59;
            uint8_t deref60;
            struct spi_transaction_result r61;
            uint8_t deref62;
            uint8_t deref63;
            uint8_t deref64;
            uint16_t let65;
            int16_t let66;
            float let67;
            uint8_t deref68;
            uint8_t deref69;
            uint16_t let70;
            int16_t let71;
            float let72;
            uint8_t deref73;
            uint8_t deref74;
            uint16_t let75;
            int16_t let76;
            float let77;
            struct spi_transaction_request local78;
            struct spi_transaction_result r80;
            uint8_t deref81;
            uint8_t deref82;
            uint8_t deref83;
            uint16_t let84;
            int16_t let85;
            float let86;
            uint8_t deref87;
            uint8_t deref88;
            uint16_t let89;
            int16_t let90;
            float let91;
            uint8_t deref92;
            uint8_t deref93;
            uint16_t let94;
            int16_t let95;
            float let96;
            int64_t r97;
        } lsm303d_coroutine_continuation;
extern bool initialized;
extern struct magnetometer_sample mag_s;
extern struct accelerometer_sample accel_s;
extern struct spi_transaction_result last_value_3;
extern struct lsm303d_coroutine_continuation lsm303d_coroutine_cont;

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_STATE_MONITOR_LSM303DSENSORMANAGER_H__ */