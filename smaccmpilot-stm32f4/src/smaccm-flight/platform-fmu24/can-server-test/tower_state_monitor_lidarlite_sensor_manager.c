/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_state_monitor_lidarlite_sensor_manager.h"

struct lidarlite_sample lidarlite_current_sample;

int64_t lidarlite_last_response;

uint8_t lidarlite_driver_state = (uint8_t) 0U;

struct i2c_transaction_result last_value_5;

struct lidarlite_coroutine_continuation lidarlite_coroutine_cont;
