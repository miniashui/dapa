/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_gyro_output_attrProxy.h"

struct mutex lock_gyro_output_attrProxy;

void monitor_init_gyro_output_attrProxy(void)
{
    ivory_freertos_mutex_create(&lock_gyro_output_attrProxy);
}

void monitor_lock_gyro_output_attrProxy(void)
{
    ivory_freertos_mutex_takeblocking(&lock_gyro_output_attrProxy);
}

void monitor_unlock_gyro_output_attrProxy(void)
{
    ivory_freertos_mutex_give(&lock_gyro_output_attrProxy);
}
