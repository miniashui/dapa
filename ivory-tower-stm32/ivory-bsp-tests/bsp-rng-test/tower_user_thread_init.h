/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_INIT_H__
#define __TOWER_USER_THREAD_INIT_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "rngTestTypes.h"
#include "tower_state_monitor_led.h"
#include "tower_state_monitor_dma.h"
#include "tower_state_monitor_rngPeripheral.h"
#include "tower_gen_thread_init.h"
#include "tower_time.h"
void callback_rngInit_thread_init(const int64_t *n_var0);
void callback_init_thread_init(const int64_t *n_var0);
void callback_hardwareinit_thread_init(const int64_t *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_INIT_H__ */
