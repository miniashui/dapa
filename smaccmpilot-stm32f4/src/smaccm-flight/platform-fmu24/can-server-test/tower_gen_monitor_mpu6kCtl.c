/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_mpu6kCtl.h"

struct mutex lock_mpu6kCtl;

void monitor_init_mpu6kCtl(void)
{
    ivory_freertos_mutex_create(&lock_mpu6kCtl);
}

void monitor_lock_mpu6kCtl(void)
{
    ivory_freertos_mutex_takeblocking(&lock_mpu6kCtl);
}

void monitor_unlock_mpu6kCtl(void)
{
    ivory_freertos_mutex_give(&lock_mpu6kCtl);
}