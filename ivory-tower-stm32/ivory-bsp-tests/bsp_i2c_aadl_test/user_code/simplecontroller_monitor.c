/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "simplecontroller_monitor.h"

void callback_periodic(const int64_t *n_var0)
{
    int64_t n_deref0 = *n_var0;
    int64_t n_cse0 = (int64_t) (n_deref0 % (int64_t) 500000);
    
    if ((bool) ((int64_t) ((bool) (n_cse0 < (int64_t) 0) ? (int64_t) (n_cse0 + (int64_t) 500000) : n_cse0) >= (int64_t) 250000)) {
        struct i2c_transaction_request n_local1 = {.tx_addr =(uint8_t) 80U, .tx_buf ={(uint8_t) 0U, (uint8_t) 242U, (uint8_t) 243U, (uint8_t) 238U}, .tx_len =(int32_t) 4, .rx_len =(int32_t) 0};
        struct i2c_transaction_request *n_ref2 = &n_local1;
        
        emitter_periodic_chan_1(n_ref2);
    } else {
        struct i2c_transaction_request n_local3 = {.tx_addr =(uint8_t) 80U, .tx_buf ={(uint8_t) 0U}, .tx_len =(int32_t) 1, .rx_len =(int32_t) 3};
        struct i2c_transaction_request *n_ref4 = &n_local3;
        
        emitter_periodic_chan_1(n_ref4);
    }
}

void callback_result(const struct i2c_transaction_result *n_var0)
{ }
