/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_MONITOR_LED_H__
#define __TOWER_GEN_MONITOR_LED_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include <freertos_mutex_wrapper.h>
extern struct mutex lock_led;
void monitor_init_led(void);
void monitor_lock_led(void);
void monitor_unlock_led(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_MONITOR_LED_H__ */
