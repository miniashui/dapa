/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_lidarlite_output_attrProxy.h"

struct mutex lock_lidarlite_output_attrProxy;

void monitor_init_lidarlite_output_attrProxy(void)
{
    ivory_freertos_mutex_create(&lock_lidarlite_output_attrProxy);
}

void monitor_lock_lidarlite_output_attrProxy(void)
{
    ivory_freertos_mutex_takeblocking(&lock_lidarlite_output_attrProxy);
}

void monitor_unlock_lidarlite_output_attrProxy(void)
{
    ivory_freertos_mutex_give(&lock_lidarlite_output_attrProxy);
}
