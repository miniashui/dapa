/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_ms5611SPISensorManager.h"

struct mutex lock_ms5611SPISensorManager;

void monitor_init_ms5611SPISensorManager(void)
{
    ivory_freertos_mutex_create(&lock_ms5611SPISensorManager);
}

void monitor_lock_ms5611SPISensorManager(void)
{
    ivory_freertos_mutex_takeblocking(&lock_ms5611SPISensorManager);
}

void monitor_unlock_ms5611SPISensorManager(void)
{
    ivory_freertos_mutex_give(&lock_ms5611SPISensorManager);
}
