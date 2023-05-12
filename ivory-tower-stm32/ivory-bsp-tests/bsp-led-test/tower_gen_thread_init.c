/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_init.h"

static void handler_run_hardwareinit_2_thread_init(const int64_t *n_var0);

static void handler_run_hardwareinit_thread_init(const int64_t *n_var0);

void loop_thread_init(void)
{
    int64_t n_local0 = (int64_t) 0;
    int64_t *n_ref1 = &n_local0;
    
    handler_run_hardwareinit_thread_init(n_ref1);
    handler_run_hardwareinit_2_thread_init(n_ref1);
    return;
}

void handler_run_hardwareinit_2_thread_init(const int64_t *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_led_2();
    /* run callbacks */
    callback_hardwareinit_2_thread_init(n_var0);
    /* release monitor lock */
    monitor_unlock_led_2();
    /* deliver emitters */
    ;
}

void handler_run_hardwareinit_thread_init(const int64_t *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_led();
    /* run callbacks */
    callback_hardwareinit_thread_init(n_var0);
    /* release monitor lock */
    monitor_unlock_led();
    /* deliver emitters */
    ;
}
