/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_time.h"

int64_t tower_get_time(void)
{
    int64_t n_r0 = clock_get_time();
    
    return (int64_t) ((int64_t) n_r0 * (int64_t) 1000);
}
