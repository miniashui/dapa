/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_GEN_THREAD_PERIOD_250MS_H__
#define __TOWER_GEN_THREAD_PERIOD_250MS_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "spiDriverTypes.h"
#include "tower_user_thread_period_250ms.h"
#include "tower_gen_monitor_simplecontroller.h"
#include "tower_gen_monitor_spi4PeripheralDriver.h"
#include <freertos_task_wrapper.h>
#include <freertos_time_wrapper.h>
void loop_thread_period_250ms(struct taskarg *n_var0);
void emitter_periodic_chan_1_thread_period_250ms_emit(const struct spi_transaction_request *n_var0);

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_GEN_THREAD_PERIOD_250MS_H__ */
