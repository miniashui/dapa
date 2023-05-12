/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_signal_I2C1_EV_IRQHandler.h"

static struct i2c_transaction_result emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_0;

static uint32_t emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_count;

struct binary_semaphore signal_semaphore_thread_signal_I2C1_EV_IRQHandler;

static void handler_run_i2c1_schedulerasync_response_thread_signal_I2C1_EV_IRQHandler(const struct i2c_transaction_result *n_var0);

static void handler_run_i2c1_event_irq_thread_signal_I2C1_EV_IRQHandler(const int64_t *n_var0);

void loop_thread_signal_I2C1_EV_IRQHandler(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_binary_semaphore_takeblocking(&signal_semaphore_thread_signal_I2C1_EV_IRQHandler);
            
            uint32_t n_r1 = ivory_freertos_time_gettickcount();
            uint32_t n_cse3 = (uint32_t) (n_r1 / n_r0);
            int64_t n_local2 = (int64_t) ((int64_t) n_cse3 * (int64_t) 1000);
            int64_t *n_ref3 = &n_local2;
            
            handler_run_i2c1_event_irq_thread_signal_I2C1_EV_IRQHandler(n_ref3);
        }
    }
}

void I2C1_EV_IRQHandler(void)
{
    uint16_t n_r0 = ivory_hw_io_read_u16((uint32_t) 1073763332U);
    
    /* reg modify i2c1->cr2: clearBit i2c_cr2_itbufen, clearBit i2c_cr2_itevten */
    ivory_hw_io_write_u16((uint32_t) 1073763332U, (uint16_t) ((uint16_t) (n_r0 & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 10U)) & (uint16_t) ~(uint16_t) ((uint16_t) 1U << (uint16_t) 9U)));
    /* reg set nvic_icer0: setBit nvic_icer_clrena.[31] */
    ivory_hw_io_write_u32((uint32_t) 3758154112U, (uint32_t) ((uint32_t) 1U << (uint32_t) 31U));
    ivory_freertos_binary_semaphore_give_from_isr(&signal_semaphore_thread_signal_I2C1_EV_IRQHandler);
}

void emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_emit(const struct i2c_transaction_result *n_var0)
{
    uint32_t n_deref0 = emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_0 = *n_var0;
    }
}

void handler_run_i2c1_schedulerasync_response_thread_signal_I2C1_EV_IRQHandler(const struct i2c_transaction_result *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_i2c1_schedulerasync();
    /* run callbacks */
    callback_i2c1_schedulerasync_response_thread_signal_I2C1_EV_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1_schedulerasync();
    /* deliver emitters */
    ;
}

void handler_run_i2c1_event_irq_thread_signal_I2C1_EV_IRQHandler(const int64_t *n_var0)
{
    /* init emitters */
    emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c1PeripheralDriver();
    /* run callbacks */
    callback_i2c1_event_irq_thread_signal_I2C1_EV_IRQHandler(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1PeripheralDriver();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_schedulerasync_response_thread_signal_I2C1_EV_IRQHandler(&emitter_i2c1_event_irq_chan_180_thread_signal_I2C1_EV_IRQHandler_message_0);
    }
}
