/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_MONITOR_RANDREPORTER_H__
#define __TOWER_GEN_MONITOR_RANDREPORTER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "rngTestTypes.h"
#include <freertos_mutex_wrapper.h>
extern struct mutex lock_randReporter;
void monitor_init_randReporter(void);
void monitor_lock_randReporter(void);
void monitor_unlock_randReporter(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_MONITOR_RANDREPORTER_H__ */