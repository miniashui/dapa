/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#ifndef __PX4FLOW_INTEGRAL_SAMPLE_TYPES_H__
#define __PX4FLOW_INTEGRAL_SAMPLE_TYPES_H__
#ifdef __cplusplus
extern "C" {
#endif
#include "ivory.h"
#include "ivory_serialize.h"
#include "time_micros_types.h"
typedef struct px4flow_integral_sample {
            uint16_t frame_count_since_last_readout;
            int16_t pixel_flow_x_integral;
            int16_t pixel_flow_y_integral;
            int16_t gyro_x_rate_integral;
            int16_t gyro_y_rate_integral;
            int16_t gyro_z_rate_integral;
            uint32_t integration_timespan;
            uint32_t sonar_timestamp;
            int16_t ground_distance;
            int16_t gyro_temperature;
            uint8_t quality;
            bool samplefail;
            int64_t time;
        } px4flow_integral_sample;
void px4flow_integral_sample_get_le(const uint8_t *n_var0, uint32_t n_var1, struct px4flow_integral_sample *n_var2);
void px4flow_integral_sample_get_be(const uint8_t *n_var0, uint32_t n_var1, struct px4flow_integral_sample *n_var2);
void px4flow_integral_sample_set_le(uint8_t *n_var0, uint32_t n_var1, const struct px4flow_integral_sample *n_var2);
void px4flow_integral_sample_set_be(uint8_t *n_var0, uint32_t n_var1, const struct px4flow_integral_sample *n_var2);

#ifdef __cplusplus
}
#endif
#endif /* __PX4FLOW_INTEGRAL_SAMPLE_TYPES_H__ */
