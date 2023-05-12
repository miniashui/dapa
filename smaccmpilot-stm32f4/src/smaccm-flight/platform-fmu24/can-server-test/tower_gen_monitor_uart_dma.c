/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_monitor_uart_dma.h"

struct mutex lock_uart_dma;

void monitor_init_uart_dma(void)
{
    ivory_freertos_mutex_create(&lock_uart_dma);
}

void monitor_lock_uart_dma(void)
{
    ivory_freertos_mutex_takeblocking(&lock_uart_dma);
}

void monitor_unlock_uart_dma(void)
{
    ivory_freertos_mutex_give(&lock_uart_dma);
}
