/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_state_monitor_px4flow_sensor_manager.h"

struct px4flow_sample px4flow_current_sample;

int64_t px4flow_last_response;

uint8_t px4flow_driver_state = (uint8_t) 0U;

struct i2c_transaction_result last_value_6;

struct px4flow_coroutine_continuation px4flow_coroutine_cont;