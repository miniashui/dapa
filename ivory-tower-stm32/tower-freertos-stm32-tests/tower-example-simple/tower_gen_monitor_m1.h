/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_MONITOR_M1_H__
#define __TOWER_GEN_MONITOR_M1_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include <freertos_mutex_wrapper.h>
extern struct mutex lock_m1;
void monitor_init_m1(void);
void monitor_lock_m1(void);
void monitor_unlock_m1(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_MONITOR_M1_H__ */
