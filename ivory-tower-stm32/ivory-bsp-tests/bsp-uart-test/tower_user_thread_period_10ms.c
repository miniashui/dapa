/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_user_thread_period_10ms.h"

static void emitter_uart_tx_flush_chan_2(const struct ivory_string_UARTBuffer *n_var0);

void callback_uart_tx_flush_thread_period_10ms(const int64_t *n_var0)
{
    bool n_deref0 = flush_defer;
    int32_t n_deref1 = buffer.ivory_string_UARTBuffer_len;
    
    if ((bool) ((bool) (n_deref1 > (int32_t) 0) && (bool) !n_deref0)) {
        emitter_uart_tx_flush_chan_2(&buffer);
        buffer.ivory_string_UARTBuffer_len = (int32_t) 0;
        flush_defer = true;
    }
}

void callback_req_chan_thread_period_10ms(const struct ivory_string_UARTBuffer *n_var0)
{
    req_buf = *n_var0;
    req_pos = (int32_t) 0;
    
    uint16_t n_r0 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setField uart_cr1_txeie */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) (n_r0 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 7U)) | (uint16_t) ((uint16_t) 1U << (uint16_t) 7U)));
}

void emitter_uart_tx_flush_chan_2(const struct ivory_string_UARTBuffer *n_var0)
{
    emitter_uart_tx_flush_chan_2_thread_period_10ms_emit(n_var0);
}
