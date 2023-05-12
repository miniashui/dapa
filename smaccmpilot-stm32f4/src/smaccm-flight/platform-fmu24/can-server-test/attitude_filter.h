/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __ATTITUDE_FILTER_H__
#define __ATTITUDE_FILTER_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
typedef struct AhrsMlkf {
            float ltp_to_imu_quat[4U];
            float gibbs_cor[4U];
            float gyro_bias[3U];
            float p[6U][6U];
            float lp_accel;
            float lp_rates[3U];
            float imu_rate[3U];
        } AhrsMlkf;

#ifdef __cplusplus
}
#endif
#endif /* __ATTITUDE_FILTER_H__ */