/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_user_thread_period_1ms.h"

static void emitter_spi_shutdown_watchdog_chan_2(const struct spi_transaction_result *n_var0);

void callback_result_thread_period_1ms(const struct spi_transaction_result *n_var0)
{
    uint8_t n_deref0 = n_var0->resultcode;
    int32_t n_deref1 = n_var0->rx_idx;
    
    ASSERTS((bool) (0 == n_deref0));
    ASSERTS((bool) ((bool) (n_deref1 == (int32_t) 3) || (bool) (n_deref1 == (int32_t) 4)));
}

void callback_spi_shutdown_watchdog_thread_period_1ms(const int64_t *n_var0)
{
    bool n_deref0 = shutdown;
    
    if (n_deref0) {
        /* reg get spi4->sr:  */
        ;
        
        uint16_t n_r1 = ivory_hw_io_read_u16((uint32_t) 1073820680U);
        
        if ((bool) (0 == (uint8_t) (uint16_t) ((uint16_t) (n_r1 >> (uint16_t) 7U) & (uint16_t) 1U))) {
            uint16_t n_r2 = ivory_hw_io_read_u16((uint32_t) 1073820672U);
            
            /* reg modify spi4->cr1: setField spi_cr1_spe */
            ;
            ivory_hw_io_write_u16((uint32_t) 1073820672U, (uint16_t) ((uint16_t) (n_r2 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 6U)) | (uint16_t) ((uint16_t) 0 << (uint16_t) 6U)));
            /* selecting device: */
            ;
            
            uint8_t n_deref3 = reqbuffer.tx_device;
            
            ASSERTS((bool) (n_deref3 < (uint8_t) 2U));
            if ((bool) (0 == n_deref3)) {
                uint32_t n_r4 = ivory_hw_io_read_u32((uint32_t) 1073877016U);
                
                /* reg modify gpioE->bsrr: setBit gpio_bs_2 */
                ;
                ivory_hw_io_write_u32((uint32_t) 1073877016U, (uint32_t) (n_r4 | (uint32_t) ((uint32_t) 1U << (uint32_t) 2U)));
            } else {
                if ((bool) ((uint8_t) 1U == n_deref3)) {
                    uint32_t n_r5 = ivory_hw_io_read_u32((uint32_t) 1073877016U);
                    
                    /* reg modify gpioE->bsrr: setBit gpio_bs_3 */
                    ;
                    ivory_hw_io_write_u32((uint32_t) 1073877016U, (uint32_t) (n_r5 | (uint32_t) ((uint32_t) 1U << (uint32_t) 3U)));
                }
            }
            /* end selecting configured device */
            ;
            emitter_spi_shutdown_watchdog_chan_2(&resbuffer);
            done = true;
            shutdown = false;
        }
    }
}

void emitter_spi_shutdown_watchdog_chan_2(const struct spi_transaction_result *n_var0)
{
    emitter_spi_shutdown_watchdog_chan_2_thread_period_1ms_emit(n_var0);
}
