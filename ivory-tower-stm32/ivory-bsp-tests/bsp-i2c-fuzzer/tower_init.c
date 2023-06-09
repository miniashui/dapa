/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_init.h"

void tower_entry(void)
{
    monitor_init_rngPeripheral();
    monitor_init_i2c_fuzzer();
    loop_thread_init();
    ivory_freertos_task_create(loop_thread_period_1ms, (uint32_t) 2560U, (uint8_t) 3U, "thread_period_1ms");
    ivory_freertos_task_create(loop_thread_period_90ms, (uint32_t) 2560U, (uint8_t) 2U, "thread_period_90ms");
}
