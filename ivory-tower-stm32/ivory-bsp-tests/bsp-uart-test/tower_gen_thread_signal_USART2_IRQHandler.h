/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_THREAD_SIGNAL_USART2_IRQHANDLER_H__
#define __TOWER_GEN_THREAD_SIGNAL_USART2_IRQHANDLER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "uartTestTypes.h"
#include "tower_user_thread_signal_USART2_IRQHandler.h"
#include "tower_gen_monitor_dma.h"
#include "tower_gen_monitor_echoprompt.h"
#include "tower_gen_monitor_settableLED.h"
#include "tower_gen_monitor_uart_unbuffer.h"
#include <freertos_task_wrapper.h>
#include <freertos_time_wrapper.h>
#include <freertos_semaphore_wrapper.h>
extern struct binary_semaphore signal_semaphore_thread_signal_USART2_IRQHandler;
void loop_thread_signal_USART2_IRQHandler(struct taskarg *n_var0);
void USART2_IRQHandler(void);
void emitter_istream_chan_1_thread_signal_USART2_IRQHandler_emit(const bool *n_var0);
void emitter_istream_chan_5_thread_signal_USART2_IRQHandler_emit(const uint8_t *n_var0);
void emitter_interrupt_chan_4_thread_signal_USART2_IRQHandler_emit(const uint8_t *n_var0);
void emitter_interrupt_chan_3_thread_signal_USART2_IRQHandler_emit(const bool *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_THREAD_SIGNAL_USART2_IRQHANDLER_H__ */