/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_MONITOR_BLINKER_2_H__
#define __TOWER_GEN_MONITOR_BLINKER_2_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include <freertos_mutex_wrapper.h>
extern struct mutex lock_blinker_2;
void monitor_init_blinker_2(void);
void monitor_lock_blinker_2(void);
void monitor_unlock_blinker_2(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_MONITOR_BLINKER_2_H__ */