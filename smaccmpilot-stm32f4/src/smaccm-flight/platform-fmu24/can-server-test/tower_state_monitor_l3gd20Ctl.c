/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_state_monitor_l3gd20Ctl.h"

uint8_t l3gd20_retries;

bool l3gd20_panic = false;

struct spi_transaction_result last_value;

struct l3gd20_continuation l3gd20_cont;
