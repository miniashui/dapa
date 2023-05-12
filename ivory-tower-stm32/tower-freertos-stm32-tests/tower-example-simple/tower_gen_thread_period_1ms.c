/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_period_1ms.h"

static int64_t emitter_tick_chan_1_thread_period_1ms_message_0;

static uint32_t emitter_tick_chan_1_thread_period_1ms_message_count;

static void handler_run_chan1msg_thread_period_1ms(const int64_t *n_var0);

static void handler_run_tick_thread_period_1ms(const int64_t *n_var0);

void loop_thread_period_1ms(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    uint32_t n_r1 = ivory_freertos_time_gettickcount();
    uint32_t n_local2 = (uint32_t) (n_r1 + (uint32_t) ((uint32_t) ((bool) ((bool) ((int64_t) 0 <= (int64_t) UINT32_MAX) && (bool) ((int64_t) 0 >= (int64_t) (uint32_t) 0U)) ? (uint32_t) (int64_t) 0 : (uint32_t) 0U) * n_r0));
    uint32_t *n_ref3 = &n_local2;
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_time_delayuntil(n_ref3, (uint32_t) (n_r0 * (uint32_t) 1U));
            
            uint32_t n_deref4 = *n_ref3;
            uint32_t n_cse13 = (uint32_t) (n_deref4 / n_r0);
            int64_t n_local5 = (int64_t) ((int64_t) (uint32_t) ((bool) ((uint32_t) (n_deref4 % n_r0) < (uint32_t) 0U) ? (uint32_t) ((bool) (n_r0 > (uint32_t) 0U) ? (uint32_t) (n_cse13 - (uint32_t) 1U) : (uint32_t) ((uint32_t) 1U + n_cse13)) : n_cse13) * (int64_t) 1000);
            int64_t *n_ref6 = &n_local5;
            
            handler_run_tick_thread_period_1ms(n_ref6);
        }
    }
}

void emitter_tick_chan_1_thread_period_1ms_emit(const int64_t *n_var0)
{
    uint32_t n_deref0 = emitter_tick_chan_1_thread_period_1ms_message_count;
    
    if ((bool) (n_deref0 <= (uint32_t) 0U)) {
        emitter_tick_chan_1_thread_period_1ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        
        int64_t *n_let1 = &emitter_tick_chan_1_thread_period_1ms_message_0;
        
        *n_let1 = *n_var0;
    }
}

void handler_run_chan1msg_thread_period_1ms(const int64_t *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_m2();
    /* run callbacks */
    callback_chan1msg_thread_period_1ms(n_var0);
    /* release monitor lock */
    monitor_unlock_m2();
    /* deliver emitters */
    ;
}

void handler_run_tick_thread_period_1ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_tick_chan_1_thread_period_1ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_m1();
    /* run callbacks */
    callback_tick_thread_period_1ms(n_var0);
    /* release monitor lock */
    monitor_unlock_m1();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_tick_chan_1_thread_period_1ms_message_count;
    
    if ((bool) ((uint32_t) 0U < n_deref0)) {
        handler_run_chan1msg_thread_period_1ms(&emitter_tick_chan_1_thread_period_1ms_message_0);
    }
}
