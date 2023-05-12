/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_gen_thread_period_20ms.h"

static struct i2c_transaction_result emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_0;

static uint32_t emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_count;

static struct i2c_transaction_request emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_0;

static uint32_t emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_count;

static struct i2c_transaction_request emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_0;

static uint32_t emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_count;

static struct i2c_transaction_request emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_0;

static uint32_t emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_count;

static struct i2c_transaction_request emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_0;

static uint32_t emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_count;

static struct i2c_transaction_result emitter_i2c1_request_chan_180_thread_period_20ms_message_0;

static uint32_t emitter_i2c1_request_chan_180_thread_period_20ms_message_count;

static struct i2c_transaction_result emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_0;

static uint32_t emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_count;

static struct spi_transaction_request emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_0;

static uint32_t emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_count;

static struct spi_transaction_request emitter_periodic_read_chan_170_thread_period_20ms_message_0;

static uint32_t emitter_periodic_read_chan_170_thread_period_20ms_message_count;

static void handler_run_i2c_response_thread_period_20ms(const struct i2c_transaction_result *n_var0);

static void handler_run_i2c2_watchdog_thread_period_20ms(const int64_t *n_var0);

static void handler_run_i2c1_schedulerasync_response_thread_period_20ms(const struct i2c_transaction_result *n_var0);

static void handler_run_i2c1_schedulerasync_px4flow_thread_period_20ms(const struct i2c_transaction_request *n_var0);

static void handler_run_i2c1_schedulerasync_lidarlite_thread_period_20ms(const struct i2c_transaction_request *n_var0);

static void handler_run_px4flow_periodic_read_thread_period_20ms(const int64_t *n_var0);

static void handler_run_lidarlite_periodic_read_thread_period_20ms(const int64_t *n_var0);

static void handler_run_i2c1_request_thread_period_20ms(const struct i2c_transaction_request *n_var0);

static void handler_run_i2c1_watchdog_thread_period_20ms(const int64_t *n_var0);

static void handler_run_spi1_scheduler_lsm303d_thread_period_20ms(const struct spi_transaction_request *n_var0);

static void handler_run_periodic_read_thread_period_20ms(const int64_t *n_var0);

static void handler_run_request_4_thread_period_20ms(const struct spi_transaction_request *n_var0);

void loop_thread_period_20ms(struct taskarg *n_var0)
{
    uint32_t n_r0 = ivory_freertos_time_gettickrate_ms();
    uint32_t n_r1 = ivory_freertos_time_gettickcount();
    uint32_t n_local2 = n_r1;
    uint32_t *n_ref3 = &n_local2;
    
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            ivory_freertos_time_delayuntil(n_ref3, (uint32_t) (n_r0 * (uint32_t) 20U));
            
            uint32_t n_deref4 = *n_ref3;
            uint32_t n_cse13 = (uint32_t) (n_deref4 / n_r0);
            int64_t n_local5 = (int64_t) ((int64_t) n_cse13 * (int64_t) 1000);
            int64_t *n_ref6 = &n_local5;
            
            handler_run_periodic_read_thread_period_20ms(n_ref6);
            handler_run_i2c1_watchdog_thread_period_20ms(n_ref6);
            handler_run_lidarlite_periodic_read_thread_period_20ms(n_ref6);
            handler_run_px4flow_periodic_read_thread_period_20ms(n_ref6);
            handler_run_i2c2_watchdog_thread_period_20ms(n_ref6);
        }
    }
}

void emitter_i2c2_watchdog_chan_191_thread_period_20ms_emit(const struct i2c_transaction_result *n_var0)
{
    uint32_t n_deref0 = emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_emit(const struct i2c_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_emit(const struct i2c_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_px4flow_periodic_read_chan_185_thread_period_20ms_emit(const struct i2c_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_emit(const struct i2c_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_i2c1_request_chan_180_thread_period_20ms_emit(const struct i2c_transaction_result *n_var0)
{
    uint32_t n_deref0 = emitter_i2c1_request_chan_180_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c1_request_chan_180_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c1_request_chan_180_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_i2c1_watchdog_chan_180_thread_period_20ms_emit(const struct i2c_transaction_result *n_var0)
{
    uint32_t n_deref0 = emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_emit(const struct spi_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_0 = *n_var0;
    }
}

void emitter_periodic_read_chan_170_thread_period_20ms_emit(const struct spi_transaction_request *n_var0)
{
    uint32_t n_deref0 = emitter_periodic_read_chan_170_thread_period_20ms_message_count;
    
    if ((bool) (n_deref0 <= 0)) {
        emitter_periodic_read_chan_170_thread_period_20ms_message_count = (uint32_t) (n_deref0 + (uint32_t) 1U);
        emitter_periodic_read_chan_170_thread_period_20ms_message_0 = *n_var0;
    }
}

void handler_run_i2c_response_thread_period_20ms(const struct i2c_transaction_result *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_rgbled();
    /* run callbacks */
    callback_i2c_response_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_rgbled();
    /* deliver emitters */
    ;
}

void handler_run_i2c2_watchdog_thread_period_20ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c2PeripheralDriver();
    /* run callbacks */
    callback_i2c2_watchdog_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c2PeripheralDriver();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c_response_thread_period_20ms(&emitter_i2c2_watchdog_chan_191_thread_period_20ms_message_0);
    }
}

void handler_run_i2c1_schedulerasync_response_thread_period_20ms(const struct i2c_transaction_result *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_i2c1_schedulerasync();
    /* run callbacks */
    callback_i2c1_schedulerasync_response_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1_schedulerasync();
    /* deliver emitters */
    ;
}

void handler_run_i2c1_schedulerasync_px4flow_thread_period_20ms(const struct i2c_transaction_request *n_var0)
{
    /* init emitters */
    emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c1_schedulerasync();
    /* run callbacks */
    callback_i2c1_schedulerasync_px4flow_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1_schedulerasync();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_request_thread_period_20ms(&emitter_i2c1_schedulerasync_px4flow_chan_179_thread_period_20ms_message_0);
    }
}

void handler_run_i2c1_schedulerasync_lidarlite_thread_period_20ms(const struct i2c_transaction_request *n_var0)
{
    /* init emitters */
    emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c1_schedulerasync();
    /* run callbacks */
    callback_i2c1_schedulerasync_lidarlite_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1_schedulerasync();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_request_thread_period_20ms(&emitter_i2c1_schedulerasync_lidarlite_chan_179_thread_period_20ms_message_0);
    }
}

void handler_run_px4flow_periodic_read_thread_period_20ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_px4flow_sensor_manager();
    /* run callbacks */
    callback_px4flow_periodic_read_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_px4flow_sensor_manager();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_schedulerasync_px4flow_thread_period_20ms(&emitter_px4flow_periodic_read_chan_185_thread_period_20ms_message_0);
    }
}

void handler_run_lidarlite_periodic_read_thread_period_20ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_lidarlite_sensor_manager();
    /* run callbacks */
    callback_lidarlite_periodic_read_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_lidarlite_sensor_manager();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_schedulerasync_lidarlite_thread_period_20ms(&emitter_lidarlite_periodic_read_chan_182_thread_period_20ms_message_0);
    }
}

void handler_run_i2c1_request_thread_period_20ms(const struct i2c_transaction_request *n_var0)
{
    /* init emitters */
    emitter_i2c1_request_chan_180_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c1PeripheralDriver();
    /* run callbacks */
    callback_i2c1_request_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1PeripheralDriver();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c1_request_chan_180_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_schedulerasync_response_thread_period_20ms(&emitter_i2c1_request_chan_180_thread_period_20ms_message_0);
    }
}

void handler_run_i2c1_watchdog_thread_period_20ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_i2c1PeripheralDriver();
    /* run callbacks */
    callback_i2c1_watchdog_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_i2c1PeripheralDriver();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_i2c1_schedulerasync_response_thread_period_20ms(&emitter_i2c1_watchdog_chan_180_thread_period_20ms_message_0);
    }
}

void handler_run_spi1_scheduler_lsm303d_thread_period_20ms(const struct spi_transaction_request *n_var0)
{
    /* init emitters */
    emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_spi1_scheduler();
    /* run callbacks */
    callback_spi1_scheduler_lsm303d_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_spi1_scheduler();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_request_4_thread_period_20ms(&emitter_spi1_scheduler_lsm303d_chan_158_thread_period_20ms_message_0);
    }
}

void handler_run_periodic_read_thread_period_20ms(const int64_t *n_var0)
{
    /* init emitters */
    emitter_periodic_read_chan_170_thread_period_20ms_message_count = (uint32_t) 0U;
    /* take monitor lock */
    monitor_lock_lsm303dSensorManager();
    /* run callbacks */
    callback_periodic_read_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_lsm303dSensorManager();
    /* deliver emitters */
    ;
    
    uint32_t n_deref0 = emitter_periodic_read_chan_170_thread_period_20ms_message_count;
    
    if ((bool) (0 < n_deref0)) {
        handler_run_spi1_scheduler_lsm303d_thread_period_20ms(&emitter_periodic_read_chan_170_thread_period_20ms_message_0);
    }
}

void handler_run_request_4_thread_period_20ms(const struct spi_transaction_request *n_var0)
{
    /* init emitters */
    /* take monitor lock */
    monitor_lock_spi1PeripheralDriver();
    /* run callbacks */
    callback_request_4_thread_period_20ms(n_var0);
    /* release monitor lock */
    monitor_unlock_spi1PeripheralDriver();
    /* deliver emitters */
    ;
}
