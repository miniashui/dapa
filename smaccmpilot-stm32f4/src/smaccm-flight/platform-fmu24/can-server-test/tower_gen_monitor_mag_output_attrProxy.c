/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_mag_output_attrProxy.h"

struct mutex lock_mag_output_attrProxy;

void monitor_init_mag_output_attrProxy(void)
{
    ivory_freertos_mutex_create(&lock_mag_output_attrProxy);
}

void monitor_lock_mag_output_attrProxy(void)
{
    ivory_freertos_mutex_takeblocking(&lock_mag_output_attrProxy);
}

void monitor_unlock_mag_output_attrProxy(void)
{
    ivory_freertos_mutex_give(&lock_mag_output_attrProxy);
}
