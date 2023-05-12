/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_sensors_output_attrServer.h"

struct mutex lock_sensors_output_attrServer;

void monitor_init_sensors_output_attrServer(void)
{
    ivory_freertos_mutex_create(&lock_sensors_output_attrServer);
}

void monitor_lock_sensors_output_attrServer(void)
{
    ivory_freertos_mutex_takeblocking(&lock_sensors_output_attrServer);
}

void monitor_unlock_sensors_output_attrServer(void)
{
    ivory_freertos_mutex_give(&lock_sensors_output_attrServer);
}