/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "USART2_IRQHandler.h"

void USART2_IRQHandler(void)
{
    /* reg set nvic_icer1: setBit nvic_icer_clrena.[6] */
    ivory_hw_io_write_u32((uint32_t) 3758154116U, (uint32_t) ((uint32_t) 1U << (uint32_t) 6U));
}
