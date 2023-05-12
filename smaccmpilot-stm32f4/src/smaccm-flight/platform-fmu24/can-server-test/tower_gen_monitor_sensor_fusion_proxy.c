/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_sensor_fusion_proxy.h"

struct mutex lock_sensor_fusion_proxy;

void monitor_init_sensor_fusion_proxy(void)
{
    ivory_freertos_mutex_create(&lock_sensor_fusion_proxy);
}

void monitor_lock_sensor_fusion_proxy(void)
{
    ivory_freertos_mutex_takeblocking(&lock_sensor_fusion_proxy);
}

void monitor_unlock_sensor_fusion_proxy(void)
{
    ivory_freertos_mutex_give(&lock_sensor_fusion_proxy);
}