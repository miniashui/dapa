/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_signal_SPI1_IRQHandler.h"

struct binary_semaphore signal_semaphore_thread_signal_SPI1_IRQHandler;

static void handler_run_irq_thread_signal_SPI1_IRQHandler(const int64_t *n_var0);

void loop_thread_signal_SPI1_IRQHandler(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_binary_semaphore_takeblocking(&signal_semaphore_thread_signal_SPI1_IRQHandler);
            
            uint32_t n_r1 = ivory_freertos_time_gettickcount();
            uint32_t n_cse3 = (uint32_t) (n_r1 / n_r0);
            int64_t n_local2 = (int64_t) ((int64_t) n_cse3 * (int64_t) 1000);
            int64_t *n_ref3 = &n_local2;
            
            handler_run_irq_thread_signal_SPI1_IRQHandler(n_ref3);
        }
    }
}

void SPI1_IRQHandler(void)
{
    /* debugToggle: make sure pin stays hi/lo long enough to see on my crummy logic analyzer */
    /* reg set nvic_icer1: setBit nvic_icer_clrena.[3] */
    ivory_hw_io_write_u32((uint32_t) 3758154116U, (uint32_t) ((uint32_t) 1U << (uint32_t) 3U));
    ivory_freertos_binary_semaphore_give_from_isr(&signal_semaphore_thread_signal_SPI1_IRQHandler);
}

void handler_run_irq_thread_signal_SPI1_IRQHandler(const int64_t *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_spi1PeripheralDriver();
    /* run callbacks */
    callback_irq_thread_signal_SPI1_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_spi1PeripheralDriver();
    /* deliver emitters */
    ;
}