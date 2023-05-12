/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_lidarlite_sensor_manager.h"

struct mutex lock_lidarlite_sensor_manager;

void monitor_init_lidarlite_sensor_manager(void)
{
    ivory_freertos_mutex_create(&lock_lidarlite_sensor_manager);
}

void monitor_lock_lidarlite_sensor_manager(void)
{
    ivory_freertos_mutex_takeblocking(&lock_lidarlite_sensor_manager);
}

void monitor_unlock_lidarlite_sensor_manager(void)
{
    ivory_freertos_mutex_give(&lock_lidarlite_sensor_manager);
}