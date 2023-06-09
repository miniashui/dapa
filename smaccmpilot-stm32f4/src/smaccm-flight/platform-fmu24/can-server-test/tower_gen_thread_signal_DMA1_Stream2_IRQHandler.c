/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_signal_DMA1_Stream2_IRQHandler.h"

struct binary_semaphore signal_semaphore_thread_signal_DMA1_Stream2_IRQHandler;

static void handler_run_rx_stream_interrupt_thread_signal_DMA1_Stream2_IRQHandler(const int64_t *n_var0);

void loop_thread_signal_DMA1_Stream2_IRQHandler(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_binary_semaphore_takeblocking(&signal_semaphore_thread_signal_DMA1_Stream2_IRQHandler);
            
            uint32_t n_r1 = ivory_freertos_time_gettickcount();
            uint32_t n_cse3 = (uint32_t) (n_r1 / n_r0);
            int64_t n_local2 = (int64_t) ((int64_t) n_cse3 * (int64_t) 1000);
            int64_t *n_ref3 = &n_local2;
            
            handler_run_rx_stream_interrupt_thread_signal_DMA1_Stream2_IRQHandler(n_ref3);
        }
    }
}

void DMA1_Stream2_IRQHandler(void)
{
    /* reg set nvic_icer0: setBit nvic_icer_clrena.[13] */
    ivory_hw_io_write_u32((uint32_t) 3758154112U, (uint32_t) ((uint32_t) 1U << (uint32_t) 13U));
    
    uint32_t n_r0 = ivory_hw_io_read_u32((uint32_t) 1073897536U);
    
    /* reg modify dma1->s2cr: setField dma_sxcr_tcie, setField dma_sxcr_teie, setField dma_sxcr_dmeie */
    ;
    
    uint32_t n_cse8 = (uint32_t) 0;
    
    ivory_hw_io_write_u32((uint32_t) 1073897536U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_r0 & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 4U)) | (uint32_t) (n_cse8 << (uint32_t) 4U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 2U)) | (uint32_t) (n_cse8 << (uint32_t) 2U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 1U)) |
                                                              (uint32_t) (n_cse8 << (uint32_t) 1U)));
    ivory_freertos_binary_semaphore_give_from_isr(&signal_semaphore_thread_signal_DMA1_Stream2_IRQHandler);
}

void handler_run_rx_stream_interrupt_thread_signal_DMA1_Stream2_IRQHandler(const int64_t *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_uart_dma();
    /* run callbacks */
    callback_rx_stream_interrupt_thread_signal_DMA1_Stream2_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_uart_dma();
    /* deliver emitters */
    ;
}
