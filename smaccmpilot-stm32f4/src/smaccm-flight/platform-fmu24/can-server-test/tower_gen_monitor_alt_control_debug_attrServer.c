/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_alt_control_debug_attrServer.h"

struct mutex lock_alt_control_debug_attrServer;

void monitor_init_alt_control_debug_attrServer(void)
{
    ivory_freertos_mutex_create(&lock_alt_control_debug_attrServer);
}

void monitor_lock_alt_control_debug_attrServer(void)
{
    ivory_freertos_mutex_takeblocking(&lock_alt_control_debug_attrServer);
}

void monitor_unlock_alt_control_debug_attrServer(void)
{
    ivory_freertos_mutex_give(&lock_alt_control_debug_attrServer);
}
