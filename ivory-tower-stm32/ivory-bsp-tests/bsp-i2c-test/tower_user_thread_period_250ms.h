/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_PERIOD_250MS_H__
#define __TOWER_USER_THREAD_PERIOD_250MS_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "i2cTowerTypes.h"
#include "tower_state_monitor_simplecontroller.h"
#include "tower_state_monitor_i2c1PeripheralDriver.h"
#include "tower_gen_thread_period_250ms.h"
#include "tower_time.h"
void callback_result_thread_period_250ms(const struct i2c_transaction_result *n_var0);
void callback_periodic_thread_period_250ms(const int64_t *n_var0);
void callback_i2c1_request_thread_period_250ms(const struct i2c_transaction_request *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_PERIOD_250MS_H__ */
