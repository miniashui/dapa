/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "blinker_monitor.h"

void callback_per(const int64_t *n_var0)
{
    int64_t n_deref0 = *n_var0;
    int64_t n_cse1 = (int64_t) (n_deref0 % (int64_t) 666000);
    bool n_local1 = (bool) ((int64_t) ((bool) (n_cse1 < (int64_t) 0) ? (int64_t) (n_cse1 + (int64_t) 666000) : n_cse1) < (int64_t) 333000);
    bool *n_ref2 = &n_local1;
    
    emitter_per_chan_1(n_ref2);
}
