/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_px4io_state_attrServer.h"

struct mutex lock_px4io_state_attrServer;

void monitor_init_px4io_state_attrServer(void)
{
    ivory_freertos_mutex_create(&lock_px4io_state_attrServer);
}

void monitor_lock_px4io_state_attrServer(void)
{
    ivory_freertos_mutex_takeblocking(&lock_px4io_state_attrServer);
}

void monitor_unlock_px4io_state_attrServer(void)
{
    ivory_freertos_mutex_give(&lock_px4io_state_attrServer);
}
