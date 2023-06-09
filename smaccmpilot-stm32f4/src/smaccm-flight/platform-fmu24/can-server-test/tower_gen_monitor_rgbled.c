/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_rgbled.h"

struct mutex lock_rgbled;

void monitor_init_rgbled(void)
{
    ivory_freertos_mutex_create(&lock_rgbled);
}

void monitor_lock_rgbled(void)
{
    ivory_freertos_mutex_takeblocking(&lock_rgbled);
}

void monitor_unlock_rgbled(void)
{
    ivory_freertos_mutex_give(&lock_rgbled);
}
