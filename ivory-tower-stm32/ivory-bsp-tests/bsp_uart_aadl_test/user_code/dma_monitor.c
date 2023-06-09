/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "dma_monitor.h"

uint32_t uart2_rx_overruns = (uint32_t) 0U;

uint32_t uart2_rx_success = (uint32_t) 0U;

struct ivory_string_UARTBuffer req_buf;

int32_t req_pos;

void callback_init(const int64_t *n_var0)
{
    uint32_t n_r0 = ivory_hw_io_read_u32((uint32_t) 1073887296U);
    
    /* reg modify rcc_apb1enr: setBit rcc_apb1en_uart2 */
    ivory_hw_io_write_u32((uint32_t) 1073887296U, (uint32_t) (n_r0 | (uint32_t) ((uint32_t) 1U << (uint32_t) 17U)));
    
    uint32_t n_r1 = ivory_hw_io_read_u32((uint32_t) 1073887280U);
    
    /* reg modify rcc_ahb1enr: setBit rcc_ahb1en_gpiod */
    ;
    
    uint32_t n_cse4 = (uint32_t) ((uint32_t) 1U << (uint32_t) 3U);
    
    ivory_hw_io_write_u32((uint32_t) 1073887280U, (uint32_t) (n_r1 | n_cse4));
    
    uint32_t n_r2 = ivory_hw_io_read_u32((uint32_t) 1073875976U);
    
    /* reg modify gpioD->ospeed: setField gpio_ospeed_5 */
    ;
    
    uint32_t n_cse8 = (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 10U);
    uint32_t n_cse12 = (uint32_t) (uint8_t) ((uint8_t) 2U << 0);
    uint32_t n_cse13 = (uint32_t) (n_cse12 << (uint32_t) 10U);
    
    ivory_hw_io_write_u32((uint32_t) 1073875976U, (uint32_t) ((uint32_t) (n_r2 & n_cse8) | n_cse13));
    
    uint32_t n_r3 = ivory_hw_io_read_u32((uint32_t) 1073875972U);
    
    /* reg modify gpioD->otype: setField gpio_otype_5 */
    ivory_hw_io_write_u32((uint32_t) 1073875972U, (uint32_t) ((uint32_t) (n_r3 & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 5U)) | (uint32_t) (0 << (uint32_t) 5U)));
    
    uint32_t n_r4 = ivory_hw_io_read_u32((uint32_t) 1073875980U);
    
    /* reg modify gpioD->pupd: setField gpio_pupd_5 */
    ;
    
    uint32_t n_cse26 = (uint32_t) (uint8_t) ((uint8_t) 1U << 0);
    
    ivory_hw_io_write_u32((uint32_t) 1073875980U, (uint32_t) ((uint32_t) (n_cse8 & n_r4) | (uint32_t) (n_cse26 << (uint32_t) 10U)));
    
    uint32_t n_r5 = ivory_hw_io_read_u32((uint32_t) 1073876000U);
    
    /* reg modify gpioD->afrl: setField gpio_afrl_5 */
    ;
    
    uint32_t n_cse35 = (uint32_t) (uint8_t) ((uint8_t) 7U << 0);
    
    ivory_hw_io_write_u32((uint32_t) 1073876000U, (uint32_t) ((uint32_t) (n_r5 & (uint32_t) ~(uint32_t) ((uint32_t) 15U << (uint32_t) 20U)) | (uint32_t) (n_cse35 << (uint32_t) 20U)));
    
    uint32_t n_r6 = ivory_hw_io_read_u32((uint32_t) 1073875968U);
    
    /* reg modify gpioD->mode: setField gpio_mode_5 */
    ivory_hw_io_write_u32((uint32_t) 1073875968U, (uint32_t) (n_cse13 | (uint32_t) (n_cse8 & n_r6)));
    
    uint32_t n_r7 = ivory_hw_io_read_u32((uint32_t) 1073887280U);
    
    /* reg modify rcc_ahb1enr: setBit rcc_ahb1en_gpiod */
    ivory_hw_io_write_u32((uint32_t) 1073887280U, (uint32_t) (n_cse4 | n_r7));
    
    uint32_t n_r8 = ivory_hw_io_read_u32((uint32_t) 1073875976U);
    
    /* reg modify gpioD->ospeed: setField gpio_ospeed_6 */
    ;
    
    uint32_t n_cse45 = (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 12U);
    uint32_t n_cse47 = (uint32_t) (n_cse12 << (uint32_t) 12U);
    
    ivory_hw_io_write_u32((uint32_t) 1073875976U, (uint32_t) ((uint32_t) (n_r8 & n_cse45) | n_cse47));
    
    uint32_t n_r9 = ivory_hw_io_read_u32((uint32_t) 1073875972U);
    
    /* reg modify gpioD->otype: setField gpio_otype_6 */
    ;
    
    uint32_t n_cse50 = (uint32_t) ((uint32_t) 1U << (uint32_t) 6U);
    
    ivory_hw_io_write_u32((uint32_t) 1073875972U, (uint32_t) ((uint32_t) (n_r9 & (uint32_t) ~n_cse50) | (uint32_t) (0 << (uint32_t) 6U)));
    
    uint32_t n_r10 = ivory_hw_io_read_u32((uint32_t) 1073875980U);
    
    /* reg modify gpioD->pupd: setField gpio_pupd_6 */
    ivory_hw_io_write_u32((uint32_t) 1073875980U, (uint32_t) ((uint32_t) (n_cse45 & n_r10) | (uint32_t) (n_cse26 << (uint32_t) 12U)));
    
    uint32_t n_r11 = ivory_hw_io_read_u32((uint32_t) 1073876000U);
    
    /* reg modify gpioD->afrl: setField gpio_afrl_6 */
    ivory_hw_io_write_u32((uint32_t) 1073876000U, (uint32_t) ((uint32_t) (n_r11 & (uint32_t) ~(uint32_t) ((uint32_t) 15U << (uint32_t) 24U)) | (uint32_t) (n_cse35 << (uint32_t) 24U)));
    
    uint32_t n_r12 = ivory_hw_io_read_u32((uint32_t) 1073875968U);
    
    /* reg modify gpioD->mode: setField gpio_mode_6 */
    ivory_hw_io_write_u32((uint32_t) 1073875968U, (uint32_t) (n_cse47 | (uint32_t) (n_cse45 & n_r12)));
    /* reg get uart2->cr1:  */
    ;
    
    uint16_t n_r14 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    bool n_let15 = (bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (n_r14 >> (uint16_t) 15U) & (uint16_t) 1U));
    uint32_t n_cse77 = (uint32_t) ((uint32_t) 115200U * (uint32_t) (n_let15 ? (uint32_t) 2U : (uint32_t) 4U));
    uint32_t n_cse81 = (uint32_t) ((uint32_t) 1050000000U / n_cse77);
    uint32_t n_cse89 = (uint32_t) (n_cse81 / (uint32_t) 100U);
    uint32_t n_let17 = (uint32_t) (n_cse89 << (uint32_t) 4U);
    uint32_t n_let18 = (uint32_t) (n_cse81 - (uint32_t) ((uint32_t) 100U * (uint32_t) (n_let17 >> (uint32_t) 4U)));
    uint32_t n_cse99 = (uint32_t) ((uint32_t) (n_let18 * (uint32_t) 8U) + (uint32_t) 50U);
    uint32_t n_cse102 = (uint32_t) (n_cse99 / (uint32_t) 100U);
    uint32_t n_cse109 = (uint32_t) ((uint32_t) 50U + (uint32_t) (n_let18 * (uint32_t) 16U));
    uint32_t n_cse112 = (uint32_t) (n_cse109 / (uint32_t) 100U);
    uint32_t n_let19 = (uint32_t) (n_let17 | (uint32_t) (n_let15 ? (uint32_t) (n_cse102 & (uint32_t) 7U) : (uint32_t) (n_cse112 & (uint32_t) 15U)));
    
    /* reg set uart2->brr: setField uart_brr_div */
    ivory_hw_io_write_u16((uint32_t) 1073759240U, (uint16_t) ((uint16_t) (uint32_t) (n_let19 & (uint32_t) 65535U) << 0));
    
    uint16_t n_r20 = ivory_hw_io_read_u16((uint32_t) 1073759248U);
    
    /* reg modify uart2->cr2: setField uart_cr2_stop */
    ;
    
    uint16_t n_cse134 = (uint16_t) (0 << (uint16_t) 12U);
    
    ivory_hw_io_write_u16((uint32_t) 1073759248U, (uint16_t) ((uint16_t) ((uint16_t) ~(uint16_t) ((uint16_t) 3U << (uint16_t) 12U) & n_r20) | n_cse134));
    
    uint16_t n_r21 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setField uart_cr1_m */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) (n_cse134 | (uint16_t) (n_r21 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 12U))));
    
    uint16_t n_r22 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setField uart_cr1_pce */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) (n_r22 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 10U)) | (uint16_t) ((uint16_t) 0 << (uint16_t) 10U)));
    /* reg set nvic_iser1: setBit nvic_iser_setena.[6] */
    ivory_hw_io_write_u32((uint32_t) 3758153988U, n_cse50);
    
    uint16_t n_r23 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setBit uart_cr1_txeie, setBit uart_cr1_rxneie, setBit uart_cr1_te, setBit uart_cr1_re */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) ((uint16_t) ((uint16_t) ((uint16_t) ((uint16_t) 1U << (uint16_t) 3U) | (uint16_t) ((uint16_t) 1U << (uint16_t) 5U)) | n_r23) | (uint16_t) ((uint16_t) 1U << (uint16_t) 7U)) | (uint16_t) ((uint16_t) 1U << (uint16_t) 2U)));
    
    uint16_t n_r24 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setBit uart_cr1_ue */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) (n_r24 | (uint16_t) ((uint16_t) 1U << (uint16_t) 13U)));
}

void callback_req_chan(const struct ivory_string_UARTBuffer *n_var0)
{
    req_buf = *n_var0;
    req_pos = (int32_t) 0;
    
    uint16_t n_r0 = ivory_hw_io_read_u16((uint32_t) 1073759244U);
    
    /* reg modify uart2->cr1: setField uart_cr1_txeie */
    ivory_hw_io_write_u16((uint32_t) 1073759244U, (uint16_t) ((uint16_t) (n_r0 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 7U)) | (uint16_t) ((uint16_t) 1U << (uint16_t) 7U)));
}

void callback_interrupt(const int64_t *n_var0)
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
