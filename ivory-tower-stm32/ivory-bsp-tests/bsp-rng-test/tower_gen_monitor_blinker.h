/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_MONITOR_BLINKER_H__
#define __TOWER_GEN_MONITOR_BLINKER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "rngTestTypes.h"
#include <freertos_mutex_wrapper.h>
extern struct mutex lock_blinker;
void monitor_init_blinker(void);
void monitor_lock_blinker(void);
void monitor_unlock_blinker(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_MONITOR_BLINKER_H__ */
