/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_USER_THREAD_PERIOD_10MS_H__
#define __TOWER_USER_THREAD_PERIOD_10MS_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "uartTestTypes.h"
#include "tower_state_monitor_uart_unbuffer.h"
#include "tower_state_monitor_dma.h"
#include "tower_gen_thread_period_10ms.h"
#include "tower_time.h"
void callback_uart_tx_flush_thread_period_10ms(const int64_t *n_var0);
void callback_req_chan_thread_period_10ms(const struct ivory_string_UARTBuffer *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_USER_THREAD_PERIOD_10MS_H__ */