/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_motion_light_debug.h"

struct mutex lock_motion_light_debug;

void monitor_init_motion_light_debug(void)
{
    ivory_freertos_mutex_create(&lock_motion_light_debug);
}

void monitor_lock_motion_light_debug(void)
{
    ivory_freertos_mutex_takeblocking(&lock_motion_light_debug);
}

void monitor_unlock_motion_light_debug(void)
{
    ivory_freertos_mutex_give(&lock_motion_light_debug);
}