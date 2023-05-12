/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_SIGNAL_I2C1_EV_IRQHANDLER_H__
#define __TOWER_USER_THREAD_SIGNAL_I2C1_EV_IRQHANDLER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "i2cTowerTypes.h"
#include "tower_state_monitor_i2c1PeripheralDriver.h"
#include "tower_state_monitor_simplecontroller.h"
#include "tower_gen_thread_signal_I2C1_EV_IRQHandler.h"
#include "tower_time.h"
void callback_result_thread_signal_I2C1_EV_IRQHandler(const struct i2c_transaction_result *n_var0);
void callback_i2c1_event_irq_thread_signal_I2C1_EV_IRQHandler(const int64_t *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_SIGNAL_I2C1_EV_IRQHANDLER_H__ */