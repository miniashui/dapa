/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __UART_UNBUFFER_MONITOR_H__
#define __UART_UNBUFFER_MONITOR_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "uartTestTypes.h"
#include "towerDeps.h"
#include "main.h"
#include "tower_time.h"
#include <smaccm_uart_unbuffer.h>
extern bool flush_defer;
extern struct ivory_string_UARTBuffer buffer;
void callback_uart_byte_tosend(const uint8_t *n_var0);
void callback_uart_tx_flush(const int64_t *n_var0);
void callback_uart_tx_res(const bool *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __UART_UNBUFFER_MONITOR_H__ */
