/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_THREAD_SIGNAL_CAN1_TX_IRQHANDLER_H__
#define __TOWER_GEN_THREAD_SIGNAL_CAN1_TX_IRQHANDLER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "canDriverTypes.h"
#include "tower_user_thread_signal_CAN1_TX_IRQHandler.h"
#include "tower_gen_monitor_can1PeripheralDriver.h"
#include "tower_gen_monitor_simplecontroller.h"
#include <freertos_task_wrapper.h>
#include <freertos_time_wrapper.h>
#include <freertos_semaphore_wrapper.h>
extern struct binary_semaphore signal_semaphore_thread_signal_CAN1_TX_IRQHandler;
void loop_thread_signal_CAN1_TX_IRQHandler(struct taskarg *n_var0);
void CAN1_TX_IRQHandler(void);
void emitter_tx_complete_chan_2_thread_signal_CAN1_TX_IRQHandler_emit(const struct can_message *n_var0);
void emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_emit(const bool *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_THREAD_SIGNAL_CAN1_TX_IRQHANDLER_H__ */