/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_gps_output_attrProxy.h"

struct mutex lock_gps_output_attrProxy;

void monitor_init_gps_output_attrProxy(void)
{
    ivory_freertos_mutex_create(&lock_gps_output_attrProxy);
}

void monitor_lock_gps_output_attrProxy(void)
{
    ivory_freertos_mutex_takeblocking(&lock_gps_output_attrProxy);
}

void monitor_unlock_gps_output_attrProxy(void)
{
    ivory_freertos_mutex_give(&lock_gps_output_attrProxy);
}
