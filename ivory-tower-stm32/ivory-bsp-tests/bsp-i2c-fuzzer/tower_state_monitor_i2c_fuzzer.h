/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __TOWER_STATE_MONITOR_I2C_FUZZER_H__
#define __TOWER_STATE_MONITOR_I2C_FUZZER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include <ivory_hw_prim.h>
typedef struct use_rng_continuation {
            uint32_t state;
            uint32_t r0;
            uint32_t deref1;
            uint32_t r2;
            uint32_t deref3;
            uint32_t r4;
            uint32_t deref5;
            int64_t deref6;
            int64_t r7;
            uint32_t r8;
            uint32_t deref9;
            uint32_t r10;
            uint32_t deref11;
            uint32_t r12;
            uint32_t deref13;
        } use_rng_continuation;
extern int64_t next_delay;
extern int64_t next_run;
extern uint32_t sda_pattern;
extern uint32_t scl_pattern;
extern uint32_t last_value;
extern struct use_rng_continuation use_rng_cont;

#ifdef __cplusplus
}
#endif
#endif /* __TOWER_STATE_MONITOR_I2C_FUZZER_H__ */
