/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_rc_input_attrServer.h"

struct mutex lock_rc_input_attrServer;

void monitor_init_rc_input_attrServer(void)
{
    ivory_freertos_mutex_create(&lock_rc_input_attrServer);
}

void monitor_lock_rc_input_attrServer(void)
{
    ivory_freertos_mutex_takeblocking(&lock_rc_input_attrServer);
}

void monitor_unlock_rc_input_attrServer(void)
{
    ivory_freertos_mutex_give(&lock_rc_input_attrServer);
}