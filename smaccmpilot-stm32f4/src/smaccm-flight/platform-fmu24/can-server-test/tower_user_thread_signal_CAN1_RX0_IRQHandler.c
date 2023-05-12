/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "tower_user_thread_signal_CAN1_RX0_IRQHandler.h"

static void emitter_rx0_irq_chan_1(const struct can_message *n_var0);

void callback_push_thread_signal_CAN1_RX0_IRQHandler(const struct can_message *n_var0)
{
    bool n_r0 = frameBuffer_2_ringbuffer_push(n_var0);
}

void callback_rx0_irq_thread_signal_CAN1_RX0_IRQHandler(const int64_t *n_var0)
{
    for (int32_t n_ix0 = (int32_t) 0; n_ix0 <= (int32_t) 2; n_ix0++) {
        /* reg get can1->rf0r:  */
        ;
        
        uint32_t n_r1 = ivory_hw_io_read_u32((uint32_t) 1073767436U);
        
        if ((bool) ((uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r1 >> 0) & (uint32_t) 3U) & (uint16_t) 255U) == 0)) {
            break;
        }
        if ((bool) (0 == (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r1 >> (uint32_t) 5U) & (uint32_t) 1U) & (uint16_t) 255U))) {
            /* reg get can1->ri0r:  */
            ;
            
            uint32_t n_r2 = ivory_hw_io_read_u32((uint32_t) 1073767856U);
            
            /* reg get can1->rdt0r:  */
            ;
            
            uint32_t n_r3 = ivory_hw_io_read_u32((uint32_t) 1073767860U);
            
            /* reg get can1->rdl0r:  */
            ;
            
            uint32_t n_r4 = ivory_hw_io_read_u32((uint32_t) 1073767864U);
            
            /* reg get can1->rdh0r:  */
            ;
            
            uint32_t n_r5 = ivory_hw_io_read_u32((uint32_t) 1073767868U);
            
            /* reg set can1->rf0r: setBit can_rfr_rfom, setBit can_rfr_fovr, setBit can_rfr_full */
            ;
            ivory_hw_io_write_u32((uint32_t) 1073767436U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) 1U << (uint32_t) 5U) | (uint32_t) ((uint32_t) 1U << (uint32_t) 4U)) | (uint32_t) ((uint32_t) 1U << (uint32_t) 3U)));
            
            struct can_message n_local6 = {.can_message_id =(uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_r2 >> (uint32_t) 3U) & (uint32_t) 536870911U) << (uint32_t) 2U) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 1U)) | (uint32_t) ((uint32_t) (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r2 >> (uint32_t) 2U) & (uint32_t) 1U) &
                                                                                                                                                                                                                                                                                                                            (uint16_t) 255U) << (uint32_t) 1U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << 0)) |
                                                                        (uint32_t) ((uint32_t) (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r2 >> (uint32_t) 1U) & (uint32_t) 1U) & (uint16_t) 255U) << 0)), .can_message_buf ={(uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r4 >> 0) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r4 >> (uint32_t) 8U) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r4 >> (uint32_t) 16U) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r4 >> (uint32_t) 24U) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r5 >> 0) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r5 >> (uint32_t) 8U) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r5 >> (uint32_t) 16U) & (uint32_t) 255U) & (uint16_t) 255U),
                                                                                                                                                                                                                                              (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r5 >> (uint32_t) 24U) & (uint32_t) 255U) & (uint16_t) 255U)}, .can_message_len =
                                           (int32_t) (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r3 >> 0) & (uint32_t) 15U) & (uint16_t) 255U) % 9};
            struct can_message *n_ref7 = &n_local6;
            
            emitter_rx0_irq_chan_1(n_ref7);
        }
    }
    /* reg set nvic_iser0: setBit nvic_iser_setena.[20] */
    ivory_hw_io_write_u32((uint32_t) 3758153984U, (uint32_t) ((uint32_t) 1U << (uint32_t) 20U));
}

void emitter_rx0_irq_chan_1(const struct can_message *n_var0)
{
    emitter_rx0_irq_chan_1_thread_signal_CAN1_RX0_IRQHandler_emit(n_var0);
}