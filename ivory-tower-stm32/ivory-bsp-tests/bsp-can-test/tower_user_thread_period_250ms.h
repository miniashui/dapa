/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_PERIOD_250MS_H__
#define __TOWER_USER_THREAD_PERIOD_250MS_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "canDriverTypes.h"
#include "tower_state_monitor_simplecontroller.h"
#include "tower_state_monitor_can1PeripheralDriver.h"
#include "tower_gen_thread_period_250ms.h"
#include "tower_time.h"
void callback_periodic_thread_period_250ms(const int64_t *n_var0);
void callback_abort_thread_period_250ms(const bool *n_var0);
void callback_request_thread_period_250ms(const struct can_message *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_PERIOD_250MS_H__ */
