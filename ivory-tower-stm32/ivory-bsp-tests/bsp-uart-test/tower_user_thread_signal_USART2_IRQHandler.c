/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_user_thread_signal_USART2_IRQHandler.h"

static void emitter_istream_chan_1(const bool *n_var0);

static void emitter_istream_chan_5(const uint8_t *n_var0);

static void emitter_interrupt_chan_4(const uint8_t *n_var0);

static void emitter_interrupt_chan_3(const bool *n_var0);

void callback_newoutput_thread_signal_USART2_IRQHandler(const bool *n_var0)
{
    bool n_deref0 = *n_var0;
    
    if (n_deref0) {
        uint32_t n_r1 = ivory_hw_io_read_u32((uint32_t) 1073877016U);
        
        /* reg modify gpioE->bsrr: setBit gpio_br_12 */
        ;
        ivory_hw_io_write_u32((uint32_t) 1073877016U, (uint32_t) (n_r1 | (uint32_t) ((uint32_t) 1U << (uint32_t) 28U)));
        
        uint32_t n_r2 = ivory_hw_io_read_u32((uint32_t) 1073876992U);
        
        /* reg modify gpioE->mode: setField gpio_mode_12 */
        ;
        ivory_hw_io_write_u32((uint32_t) 1073876992U, (uint32_t) ((uint32_t) (n_r2 & (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 24U)) | (uint32_t) ((uint32_t) (uint8_t) ((uint8_t) 1U << 0) << (uint32_t) 24U)));
    } else {
        uint32_t n_r3 = ivory_hw_io_read_u32((uint32_t) 1073876992U);
        
        /* reg modify gpioE->mode: setField gpio_mode_12 */
        ;
        ivory_hw_io_write_u32((uint32_t) 1073876992U, (uint32_t) ((uint32_t) ((uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 24U) & n_r3) | (uint32_t) ((uint32_t) (uint8_t) ((uint8_t) 3U << 0) << (uint32_t) 24U)));
    }
}

void callback_istream_thread_signal_USART2_IRQHandler(const uint8_t *n_var0)
{
    uint8_t n_deref0 = *n_var0;
    uint8_t n_local1 = n_deref0;
    uint8_t *n_ref2 = &n_local1;
    
    emitter_istream_chan_5(n_ref2);
    if ((bool) (n_deref0 == (uint8_t) 49U)) {
        uint8_t n_local3 = (uint8_t) 13U;
        uint8_t *n_ref4 = &n_local3;
        
        emitter_istream_chan_5(n_ref4);
        
        uint8_t n_local5 = (uint8_t) 10U;
        uint8_t *n_ref6 = &n_local5;
        
        emitter_istream_chan_5(n_ref6);
        
        uint8_t n_local7 = (uint8_t) 111U;
        uint8_t *n_ref8 = &n_local7;
        
        emitter_istream_chan_5(n_ref8);
        
        uint8_t n_local9 = (uint8_t) 117U;
        uint8_t *n_ref10 = &n_local9;
        
        emitter_istream_chan_5(n_ref10);
        
        uint8_t n_local11 = (uint8_t) 116U;
        uint8_t *n_ref12 = &n_local11;
        
        emitter_istream_chan_5(n_ref12);
        
        uint8_t n_local13 = (uint8_t) 112U;
        uint8_t *n_ref14 = &n_local13;
        
        emitter_istream_chan_5(n_ref14);
        
        uint8_t n_local15 = (uint8_t) 117U;
        uint8_t *n_ref16 = &n_local15;
        
        emitter_istream_chan_5(n_ref16);
        
        uint8_t n_local17 = (uint8_t) 116U;
        uint8_t *n_ref18 = &n_local17;
        
        emitter_istream_chan_5(n_ref18);
        
        uint8_t n_local19 = (uint8_t) 32U;
        uint8_t *n_ref20 = &n_local19;
        
        emitter_istream_chan_5(n_ref20);
        
        uint8_t n_local21 = (uint8_t) 111U;
        uint8_t *n_ref22 = &n_local21;
        
        emitter_istream_chan_5(n_ref22);
        
        uint8_t n_local23 = (uint8_t) 110U;
        uint8_t *n_ref24 = &n_local23;
        
        emitter_istream_chan_5(n_ref24);
        
        uint8_t n_local25 = (uint8_t) 13U;
        uint8_t *n_ref26 = &n_local25;
        
        emitter_istream_chan_5(n_ref26);
        
        uint8_t n_local27 = (uint8_t) 10U;
        uint8_t *n_ref28 = &n_local27;
        
        emitter_istream_chan_5(n_ref28);
        
        bool n_local29 = true;
        bool *n_ref30 = &n_local29;
        
        emitter_istream_chan_1(n_ref30);
    } else {
        if ((bool) (n_deref0 == (uint8_t) 50U)) {
            uint8_t n_local31 = (uint8_t) 13U;
            uint8_t *n_ref32 = &n_local31;
            
            emitter_istream_chan_5(n_ref32);
            
            uint8_t n_local33 = (uint8_t) 10U;
            uint8_t *n_ref34 = &n_local33;
            
            emitter_istream_chan_5(n_ref34);
            
            uint8_t n_local35 = (uint8_t) 111U;
            uint8_t *n_ref36 = &n_local35;
            
            emitter_istream_chan_5(n_ref36);
            
            uint8_t n_local37 = (uint8_t) 117U;
            uint8_t *n_ref38 = &n_local37;
            
            emitter_istream_chan_5(n_ref38);
            
            uint8_t n_local39 = (uint8_t) 116U;
            uint8_t *n_ref40 = &n_local39;
            
            emitter_istream_chan_5(n_ref40);
            
            uint8_t n_local41 = (uint8_t) 112U;
            uint8_t *n_ref42 = &n_local41;
            
            emitter_istream_chan_5(n_ref42);
            
            uint8_t n_local43 = (uint8_t) 117U;
            uint8_t *n_ref44 = &n_local43;
            
            emitter_istream_chan_5(n_ref44);
            
            uint8_t n_local45 = (uint8_t) 116U;
            uint8_t *n_ref46 = &n_local45;
            
            emitter_istream_chan_5(n_ref46);
            
            uint8_t n_local47 = (uint8_t) 32U;
            uint8_t *n_ref48 = &n_local47;
            
            emitter_istream_chan_5(n_ref48);
            
            uint8_t n_local49 = (uint8_t) 111U;
            uint8_t *n_ref50 = &n_local49;
            
            emitter_istream_chan_5(n_ref50);
            
            uint8_t n_local51 = (uint8_t) 102U;
            uint8_t *n_ref52 = &n_local51;
            
            emitter_istream_chan_5(n_ref52);
            
            uint8_t n_local53 = (uint8_t) 102U;
            uint8_t *n_ref54 = &n_local53;
            
            emitter_istream_chan_5(n_ref54);
            
            uint8_t n_local55 = (uint8_t) 13U;
            uint8_t *n_ref56 = &n_local55;
            
            emitter_istream_chan_5(n_ref56);
            
            uint8_t n_local57 = (uint8_t) 10U;
            uint8_t *n_ref58 = &n_local57;
            
            emitter_istream_chan_5(n_ref58);
            
            bool n_local59 = false;
            bool *n_ref60 = &n_local59;
            
            emitter_istream_chan_1(n_ref60);
        } else {
            if ((bool) (n_deref0 == (uint8_t) 10U)) {
                uint8_t n_local61 = (uint8_t) 116U;
                uint8_t *n_ref62 = &n_local61;
                
                emitter_istream_chan_5(n_ref62);
                
                uint8_t n_local63 = (uint8_t) 111U;
                uint8_t *n_ref64 = &n_local63;
                
                emitter_istream_chan_5(n_ref64);
                
                uint8_t n_local65 = (uint8_t) 119U;
                uint8_t *n_ref66 = &n_local65;
                
                emitter_istream_chan_5(n_ref66);
                
                uint8_t n_local67 = (uint8_t) 101U;
                uint8_t *n_ref68 = &n_local67;
                
                emitter_istream_chan_5(n_ref68);
                
                uint8_t n_local69 = (uint8_t) 114U;
                uint8_t *n_ref70 = &n_local69;
                
                emitter_istream_chan_5(n_ref70);
                
                uint8_t n_local71 = (uint8_t) 62U;
                uint8_t *n_ref72 = &n_local71;
                
                emitter_istream_chan_5(n_ref72);
                
                uint8_t n_local73 = (uint8_t) 32U;
                uint8_t *n_ref74 = &n_local73;
                
                emitter_istream_chan_5(n_ref74);
            }
        }
    }
}

void callback_uart_tx_res_thread_signal_USART2_IRQHandler(const bool *n_var0)
{
    flush_defer = false;
}

void callback_uart_byte_tosend_thread_signal_USART2_IRQHandler(const uint8_t *n_var0)
{
    uint8_t n_deref0 = *n_var0;
    int32_t n_deref1 = buffer.ivory_string_UARTBuffer_len;
    
    if ((bool) (n_deref1 < (int32_t) 128)) {
        buffer.ivory_string_UARTBuffer_data[n_deref1 % 128] = n_deref0;
        buffer.ivory_string_UARTBuffer_len = (int32_t) (n_deref1 + (int32_t) 1);
    }
}

void callback_interrupt_thread_signal_USART2_IRQHandler(const int64_t *n_var0)
{
    /* reg get uart2->sr:  */
    ;
    
    uint16_t n_r0 = ivory_hw_io_read_u16((uint32_t) 1073759232U);
    
    if ((bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (n_r0 >> (uint16_t) 3U) & (uint16_t) 1U))) {
        /* reg get uart2->dr:  */
        ;
        
        uint16_t n_r1 = ivory_hw_io_read_u16((uint32_t) 1073759236U);
        uint8_t n_local2 = (uint8_t) (uint16_t) ((uint16_t) (n_r1 >> 0) & (uint16_t) 255U);
        uint8_t *n_ref3 = &n_local2;
        
        emitter_interrupt_chan_4(n_ref3);
        
        uint32_t n_deref4 = uart2_rx_overruns;
        
        uart2_rx_overruns = (uint32_t) ((uint32_t) 1U + n_deref4);
    }
    if ((bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (n_r0 >> (uint16_t) 5U) & (uint16_t) 1U))) {
        /* reg get uart2->dr:  */
        ;
        
        uint16_t n_r5 = ivory_hw_io_read_u16((uint32_t) 1073759236U);
        uint8_t n_local6 = (uint8_t) (uint16_t) ((uint16_t) (n_r5 >> 0) & (uint16_t) 255U);
        uint8_t *n_ref7 = &n_local6;
        
        emitter_interrupt_chan_4(n_ref7);
        
        uint32_t n_deref8 = uart2_rx_success;
        
        uart2_rx_success = (uint32_t) ((uint32_t) 1U + n_deref8);
    }
    if ((bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (n_r0 >> (uint16_t) 7U) & (uint16_t) 1U))) {
        uint8_t n_local9 = (uint8_t) 0U;
        uint8_t *n_ref10 = &n_local9;
        bool n_local11 = false;
        bool *n_ref12 = &n_local11;
        int32_t n_deref13 = req_pos;
        const int32_t *n_cse31 = &req_buf.ivory_string_UARTBuffer_len;
        int32_t n_deref14 = *n_cse31;
        uint8_t *n_let15 = req_buf.ivory_string_UARTBuffer_data;
        
        if ((bool) (n_deref13 < n_deref14)) {
            uint8_t n_deref16 = n_let15[n_deref13 % 128];
            
            *n_ref10 = n_deref16;
            req_pos = (int32_t) ((int32_t) 1 + n_deref13);
            *n_ref12 = true;
        }
        
        bool n_deref17 = *n_ref12;
        
        if (n_deref17) {
            uint8_t n_deref18 = *n_ref10;
            
            /* reg set uart2->dr: setField uart_dr_data */
            ;
            ivory_hw_io_write_u16((uint32_t) 1073759236U, (uint16_t) ((uint16_t) n_deref18 << 0));
        } else {
            int32_t n_deref19 = *n_cse31;
            bool n_let20 = (bool) (n_deref19 > (int32_t) 0);
            
            if (n_let20) {
                bool n_local21 = true;
                bool *n_ref22 = &n_local21;
                
                emitter_interrupt_chan_3(n_ref22);
            }
            req_buf.ivory_string_UARTBuffer_len = (int32_t) 0;
            
            uint16_t n_r23 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
            
            /* reg modify uart2->cr1: setField uart_cr1_txeie */
            ;
            ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) (n_r23 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 7U)) | (uint16_t) ((uint16_t) 0 << (uint16_t) 7U)));
        }
    }
    /* reg set nvic_iser1: setBit nvic_iser_setena.[6] */
    ivory_hw_io_write_u32((uint32_t) 3758153988U, (uint32_t) ((uint32_t) 1U << (uint32_t) 6U));
}

void emitter_istream_chan_1(const bool *n_var0)
{
    emitter_istream_chan_1_thread_signal_USART2_IRQHandler_emit(n_var0);
}

void emitter_istream_chan_5(const uint8_t *n_var0)
{
    emitter_istream_chan_5_thread_signal_USART2_IRQHandler_emit(n_var0);
}

void emitter_interrupt_chan_4(const uint8_t *n_var0)
{
    emitter_interrupt_chan_4_thread_signal_USART2_IRQHandler_emit(n_var0);
}

void emitter_interrupt_chan_3(const bool *n_var0)
{
    emitter_interrupt_chan_3_thread_signal_USART2_IRQHandler_emit(n_var0);
}
