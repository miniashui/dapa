/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_user_thread_period_1ms.h"

static void emitter_init_2_chan_2(const struct ivory_string_UARTBuffer *n_var0);

void callback_init_2_thread_period_1ms(const int64_t *n_var0)
{
    bool n_deref0 = initialized;
    
    if ((bool) !n_deref0) {
        initialized = true;
        
        const int32_t *n_cse0 = &out_req.ivory_string_UARTBuffer_len;
        int32_t n_deref1 = *n_cse0;
        
        if ((bool) (n_deref1 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref1 % 128] = (uint8_t) 98U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) (n_deref1 + (int32_t) 1);
        }
        
        int32_t n_deref2 = *n_cse0;
        
        if ((bool) (n_deref2 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref2 % 128] = (uint8_t) 115U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref2);
        }
        
        int32_t n_deref3 = *n_cse0;
        
        if ((bool) (n_deref3 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref3 % 128] = (uint8_t) 112U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref3);
        }
        
        int32_t n_deref4 = *n_cse0;
        
        if ((bool) (n_deref4 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref4 % 128] = (uint8_t) 45U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref4);
        }
        
        int32_t n_deref5 = *n_cse0;
        
        if ((bool) (n_deref5 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref5 % 128] = (uint8_t) 114U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref5);
        }
        
        int32_t n_deref6 = *n_cse0;
        
        if ((bool) (n_deref6 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref6 % 128] = (uint8_t) 110U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref6);
        }
        
        int32_t n_deref7 = *n_cse0;
        
        if ((bool) (n_deref7 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref7 % 128] = (uint8_t) 103U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref7);
        }
        
        int32_t n_deref8 = *n_cse0;
        
        if ((bool) (n_deref8 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref8 % 128] = (uint8_t) 45U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref8);
        }
        
        int32_t n_deref9 = *n_cse0;
        
        if ((bool) (n_deref9 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref9 % 128] = (uint8_t) 116U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref9);
        }
        
        int32_t n_deref10 = *n_cse0;
        
        if ((bool) (n_deref10 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref10 % 128] = (uint8_t) 101U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref10);
        }
        
        int32_t n_deref11 = *n_cse0;
        
        if ((bool) (n_deref11 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref11 % 128] = (uint8_t) 115U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref11);
        }
        
        int32_t n_deref12 = *n_cse0;
        
        if ((bool) (n_deref12 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref12 % 128] = (uint8_t) 116U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref12);
        }
        
        int32_t n_deref13 = *n_cse0;
        
        if ((bool) (n_deref13 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref13 % 128] = (uint8_t) 13U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref13);
        }
        
        int32_t n_deref14 = *n_cse0;
        
        if ((bool) (n_deref14 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref14 % 128] = (uint8_t) 10U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref14);
        }
        
        int32_t n_deref15 = *n_cse0;
        
        if ((bool) (n_deref15 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref15 % 128] = (uint8_t) 13U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref15);
        }
        
        int32_t n_deref16 = *n_cse0;
        
        if ((bool) (n_deref16 < (int32_t) 128)) {
            out_req.ivory_string_UARTBuffer_data[n_deref16 % 128] = (uint8_t) 10U;
            out_req.ivory_string_UARTBuffer_len = (int32_t) ((int32_t) 1 + n_deref16);
        }
        emitter_init_2_chan_2(&out_req);
        out_req.ivory_string_UARTBuffer_len = (int32_t) 0;
    }
}

void callback_req_chan_thread_period_1ms(const struct ivory_string_UARTBuffer *n_var0)
{
    req_buf = *n_var0;
    req_pos = (int32_t) 0;
    
    uint16_t n_r0 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setField uart_cr1_txeie */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) (n_r0 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 7U)) | (uint16_t) ((uint16_t) 1U << (uint16_t) 7U)));
}

void emitter_init_2_chan_2(const struct ivory_string_UARTBuffer *n_var0)
{
    emitter_init_2_chan_2_thread_period_1ms_emit(n_var0);
}