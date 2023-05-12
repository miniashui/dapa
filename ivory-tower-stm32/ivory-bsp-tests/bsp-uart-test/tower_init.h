/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_INIT_H__
#define __TOWER_INIT_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "tower_gen_monitor_dma.h"
#include "tower_gen_monitor_uart_unbuffer.h"
#include "tower_gen_monitor_echoprompt.h"
#include "tower_gen_monitor_settableLED.h"
#include "tower_gen_thread_signal_USART2_IRQHandler.h"
#include "tower_gen_thread_period_1ms.h"
#include "tower_gen_thread_period_10ms.h"
#include "tower_gen_thread_init.h"
#include <freertos_task_wrapper.h>
void tower_entry(void);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_INIT_H__ */