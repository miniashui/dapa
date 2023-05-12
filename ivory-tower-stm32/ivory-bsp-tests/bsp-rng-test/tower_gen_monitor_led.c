/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_led.h"

struct mutex lock_led;

void monitor_init_led(void)
{
    ivory_freertos_mutex_create(&lock_led);
}

void monitor_lock_led(void)
{
    ivory_freertos_mutex_takeblocking(&lock_led);
}

void monitor_unlock_led(void)
{
    ivory_freertos_mutex_give(&lock_led);
}