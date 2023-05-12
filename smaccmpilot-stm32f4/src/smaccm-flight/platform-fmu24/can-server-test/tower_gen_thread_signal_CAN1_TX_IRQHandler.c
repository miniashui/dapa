/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_signal_CAN1_TX_IRQHandler.h"

static uint8_t emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_0[80U];

static uint32_t emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_count;

static struct can_message emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0;

static uint32_t emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;

static bool emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_0;

static uint32_t emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_count;

static struct can_message emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0;

static uint32_t emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;

static bool emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_0;

static uint32_t emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_count;

struct binary_semaphore signal_semaphore_thread_signal_CAN1_TX_IRQHandler;

static void handler_run_fragment_done_thread_signal_CAN1_TX_IRQHandler(const bool *n_var0);

static void handler_run_fragment_complete_0x100_thread_signal_CAN1_TX_IRQHandler(const bool *n_var0);

static void handler_run_fragment_req_0x100_thread_signal_CAN1_TX_IRQHandler(const uint8_t n_var0[80U]);

static void handler_run_tx_irq_thread_signal_CAN1_TX_IRQHandler(const int64_t *n_var0);

static void handler_run_request_thread_signal_CAN1_TX_IRQHandler(const struct can_message *n_var0);

void loop_thread_signal_CAN1_TX_IRQHandler(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_binary_semaphore_takeblocking(&signal_semaphore_thread_signal_CAN1_TX_IRQHandler);
            
            uint32_t n_r1 = ivory_freertos_time_gettickcount();
            uint32_t n_cse3 = (uint32_t) (n_r1 / n_r0);
            int64_t n_local2 = (int64_t) ((int64_t) n_cse3 * (int64_t) 1000);
            int64_t *n_ref3 = &n_local2;
            
            handler_run_tx_irq_thread_signal_CAN1_TX_IRQHandler(n_ref3);
        }
    }
}

void CAN1_TX_IRQHandler(void)
{
    /* reg set nvic_icer0: setBit nvic_icer_clrena.[19] */
    ivory_hw_io_write_u32((uint32_t) 3758154112U, (uint32_t) ((uint32_t) 1U << (uint32_t) 19U));
    ivory_freertos_binary_semaphore_give_from_isr(&signal_semaphore_thread_signal_CAN1_TX_IRQHandler);
}

void emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_emit(const uint8_t n_var0[80U])
{
    uint32_t n_deref0 = emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        if (emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_0 != n_var0)
            memcpy(emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_0, n_var0, sizeof(uint8_t [80U]));
        else
            COMPILER_ASSERTS(false);
    }
}

void emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_emit(const struct can_message *n_var0)
{
    uint32_t n_deref0 = emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0 = *n_var0;
    }
}

void emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_emit(const bool *n_var0)
{
    uint32_t n_deref0 = emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_0 = *n_var0;
    }
}

void emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_emit(const struct can_message *n_var0)
{
    uint32_t n_deref0 = emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0 = *n_var0;
    }
}

void emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_emit(const bool *n_var0)
{
    uint32_t n_deref0 = emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_0 = *n_var0;
    }
}

void handler_run_fragment_done_thread_signal_CAN1_TX_IRQHandler(const bool *n_var0)
{
    /* init emitters */
    emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_fragment_blindly_0x100();
    /* run callbacks */
    callback_fragment_done_thread_signal_CAN1_TX_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_fragment_blindly_0x100();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_fragment_req_0x100_thread_signal_CAN1_TX_IRQHandler(emitter_fragment_done_chan_144_thread_signal_CAN1_TX_IRQHandler_message_0);
    }
}

void handler_run_fragment_complete_0x100_thread_signal_CAN1_TX_IRQHandler(const bool *n_var0)
{
    /* init emitters */
    emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) 0U;
    emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_fragment_0x100();
    /* run callbacks */
    callback_fragment_complete_0x100_thread_signal_CAN1_TX_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_fragment_0x100();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_request_thread_signal_CAN1_TX_IRQHandler(&emitter_fragment_complete_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0);
    }
    
    uint32_t n_deref1 = emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref1)) {
        handler_run_fragment_done_thread_signal_CAN1_TX_IRQHandler(&emitter_fragment_complete_0x100_chan_146_thread_signal_CAN1_TX_IRQHandler_message_0);
    }
}

void handler_run_fragment_req_0x100_thread_signal_CAN1_TX_IRQHandler(const uint8_t n_var0[80U])
{
    /* init emitters */
    emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_fragment_0x100();
    /* run callbacks */
    callback_fragment_req_0x100_thread_signal_CAN1_TX_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_fragment_0x100();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_request_thread_signal_CAN1_TX_IRQHandler(&emitter_fragment_req_0x100_chan_2_thread_signal_CAN1_TX_IRQHandler_message_0);
    }
}

void handler_run_tx_irq_thread_signal_CAN1_TX_IRQHandler(const int64_t *n_var0)
{
    /* init emitters */
    emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_can1PeripheralDriver();
    /* run callbacks */
    callback_tx_irq_thread_signal_CAN1_TX_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_can1PeripheralDriver();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_fragment_complete_0x100_thread_signal_CAN1_TX_IRQHandler(&emitter_tx_irq_chan_3_thread_signal_CAN1_TX_IRQHandler_message_0);
    }
}

void handler_run_request_thread_signal_CAN1_TX_IRQHandler(const struct can_message *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_can1PeripheralDriver();
    /* run callbacks */
    callback_request_thread_signal_CAN1_TX_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_can1PeripheralDriver();
    /* deliver emitters */
    ;
}
