/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_blinker_2.h"

struct mutex lock_blinker_2;

void monitor_init_blinker_2(void)
{
    ivory_freertos_mutex_create(&lock_blinker_2);
}

void monitor_lock_blinker_2(void)
{
    ivory_freertos_mutex_takeblocking(&lock_blinker_2);
}

void monitor_unlock_blinker_2(void)
{
    ivory_freertos_mutex_give(&lock_blinker_2);
}