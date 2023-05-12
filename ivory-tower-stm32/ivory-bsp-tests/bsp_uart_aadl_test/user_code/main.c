/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.5
 */
#include "main.h"

void init_clocks(void)
{
    /* platformClockConfig: ClockConfig {clockconfig_source = External 24000000, clockconfig_pll = PLLFactor {pll_m = 24, pll_n = 336, pll_p = 2, pll_q = 7}, clockconfig_hclk_divider = 1, clockconfig_pclk1_divider = 4, clockconfig_pclk2_divider = 2}
sysclk: 168000000
hclk:   168000000
pclk1:  42000000
pclk2:  84000000 */
    ;
    
    uint32_t n_r0 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
    
    /* reg modify rcc_cr: setBit rcc_cr_hsi_on */
    ivory_hw_io_write_u32((uint32_t) 1073887232U, (uint32_t) (n_r0 | (uint32_t) ((uint32_t) 1U << 0)));
    
    uint32_t n_r1 = ivory_hw_io_read_u32((uint32_t) 1073887240U);
    
    /* reg modify rcc_cfgr: setField rcc_cfgr_mco2, setField rcc_cfgr_mco2_pre, setField rcc_cfgr_mco1_pre, clearBit rcc_cfgr_i2ssrc, setField rcc_cfgr_mco1, setField rcc_cfgr_rtcpre, setField rcc_cfgr_ppre2, setField rcc_cfgr_ppre1, setField rcc_cfgr_hpre, setField rcc_cfgr_sws */
    ;
    
    uint32_t n_cse36 = (uint32_t) ~(uint32_t) ((uint32_t) 7U << (uint32_t) 13U);
    uint32_t n_cse41 = (uint32_t) ~(uint32_t) ((uint32_t) 7U << (uint32_t) 10U);
    uint32_t n_cse46 = (uint32_t) ~(uint32_t) ((uint32_t) 15U << (uint32_t) 4U);
    uint32_t n_cse48 = (uint32_t) (0 << (uint32_t) 4U);
    
    ivory_hw_io_write_u32((uint32_t) 1073887240U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_r1 & (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 30U)) | (uint32_t) (0 << (uint32_t) 30U)) &
                                                                                                                                                                                                                                                              (uint32_t) ~(uint32_t) ((uint32_t) 7U << (uint32_t) 27U)) | (uint32_t) (0 << (uint32_t) 27U)) & (uint32_t) ~(uint32_t) ((uint32_t) 7U <<
                                                                                                                                                                                                                                                                                                                                                                                      (uint32_t) 24U)) |
                                                                                                                                                                                                                          (uint32_t) (0 << (uint32_t) 24U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 23U)) & (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 21U)) | (uint32_t) (0 <<
                                                                                                                                                                                                                                                                                                                                                                                                  (uint32_t) 21U)) &
                                                                                                                                                                          (uint32_t) ~(uint32_t) ((uint32_t) 31U << (uint32_t) 16U)) | (uint32_t) ((uint32_t) 0 << (uint32_t) 16U)) & n_cse36) | (uint32_t) (0 << (uint32_t) 13U)) & n_cse41) | (uint32_t) (0 << (uint32_t) 10U)) & n_cse46) | n_cse48) &
                                                                          (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 2U)) | (uint32_t) (0 << (uint32_t) 2U)));
    
    uint32_t n_r2 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
    
    /* reg modify rcc_cr: clearBit rcc_cr_hse_on, clearBit rcc_cr_css_on, clearBit rcc_cr_pll_on */
    ;
    
    uint32_t n_cse56 = (uint32_t) ((uint32_t) 1U << (uint32_t) 16U);
    uint32_t n_cse62 = (uint32_t) ((uint32_t) 1U << (uint32_t) 24U);
    
    ivory_hw_io_write_u32((uint32_t) 1073887232U, (uint32_t) ((uint32_t) ((uint32_t) (n_r2 & (uint32_t) ~n_cse56) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 19U)) & (uint32_t) ~n_cse62));
    
    uint32_t n_r3 = ivory_hw_io_read_u32((uint32_t) 1073887236U);
    
    /* reg modify rcc_pllcfgr: setField rcc_pllcfgr_pllq, clearBit rcc_pllcfgr_pllsrc, setField rcc_pllcfgr_pllp, setField rcc_pllcfgr_plln, setField rcc_pllcfgr_pllm */
    ;
    
    uint32_t n_cse67 = (uint32_t) ~(uint32_t) ((uint32_t) 15U << (uint32_t) 24U);
    uint32_t n_cse73 = (uint32_t) ((uint32_t) 1U << (uint32_t) 22U);
    uint32_t n_cse77 = (uint32_t) ~(uint32_t) ((uint32_t) 3U << (uint32_t) 16U);
    uint32_t n_cse79 = (uint32_t) (0 << (uint32_t) 16U);
    uint32_t n_cse82 = (uint32_t) ~(uint32_t) ((uint32_t) 511U << (uint32_t) 6U);
    uint32_t n_cse89 = (uint32_t) ~(uint32_t) ((uint32_t) 63U << 0);
    
    ivory_hw_io_write_u32((uint32_t) 1073887236U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_r3 & n_cse67) | (uint32_t) ((uint32_t) 2U << (uint32_t) 24U)) & (uint32_t) ~n_cse73) & n_cse77) | n_cse79) & n_cse82) | (uint32_t) ((uint32_t) 192U << (uint32_t) 6U)) & n_cse89) | (uint32_t) ((uint32_t) 16U << 0)));
    
    uint32_t n_r4 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
    
    /* reg modify rcc_cr: clearBit rcc_cr_hse_byp */
    ivory_hw_io_write_u32((uint32_t) 1073887232U, (uint32_t) (n_r4 & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 18U)));
    
    uint32_t n_r5 = ivory_hw_io_read_u32((uint32_t) 1073887244U);
    
    /* reg modify rcc_cir: clearBit rcc_cir_plli2s_rdyie, clearBit rcc_cir_pll_rdyie, clearBit rcc_cir_hse_rdyie, clearBit rcc_cir_hsi_rdyie, clearBit rcc_cir_lse_rdyie, clearBit rcc_cir_lsi_rdyie */
    ;
    
    uint32_t n_cse109 = (uint32_t) ((uint32_t) 1U << (uint32_t) 10U);
    uint32_t n_cse112 = (uint32_t) ((uint32_t) 1U << (uint32_t) 9U);
    
    ivory_hw_io_write_u32((uint32_t) 1073887244U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_r5 & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 13U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 12U)) & (uint32_t) ~(uint32_t) ((uint32_t) 1U << (uint32_t) 11U)) & (uint32_t) ~n_cse109) & (uint32_t) ~n_cse112) & (uint32_t) ~(uint32_t) ((uint32_t) 1U <<
                                                                                                                                                                                                                                                                                                                                                                                             (uint32_t) 8U)));
    
    uint32_t n_r6 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
    
    /* reg modify rcc_cr: setBit rcc_cr_hse_on */
    ivory_hw_io_write_u32((uint32_t) 1073887232U, (uint32_t) (n_cse56 | n_r6));
    
    bool n_local7 = false;
    bool *n_ref8 = &n_local7;
    
    for (int32_t n_ix9 = (int32_t) 0; n_ix9 <= (int32_t) 1023; n_ix9++) {
        /* reg get rcc_cr:  */
        ;
        
        uint32_t n_r10 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
        
        if ((bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r10 >> (uint32_t) 17U) & (uint32_t) 1U) & (uint16_t) 255U))) {
            *n_ref8 = true;
            break;
        }
    }
    
    bool n_deref11 = *n_ref8;
    
    if (n_deref11) {
        uint32_t n_r12 = ivory_hw_io_read_u32((uint32_t) 1073887236U);
        
        /* reg modify rcc_pllcfgr: setBit rcc_pllcfgr_pllsrc */
        ;
        ivory_hw_io_write_u32((uint32_t) 1073887236U, (uint32_t) (n_cse73 | n_r12));
    }
    if ((bool) !n_deref11) {
        /* waiting for HSERDY failed: check your hardware for a fault */
        ;
        /* XXX handle this exception case with a breakpoint or reconfigure pll values for hsi */
        ;
        {
            int forever_loop __attribute__((unused));
            
            for (forever_loop = 0; IFOREVER; IFOREVER_INC) { }
        }
    }
    
    uint32_t n_r13 = ivory_hw_io_read_u32((uint32_t) 1073887296U);
    
    /* reg modify rcc_apb1enr: setBit rcc_apb1en_pwr */
    ivory_hw_io_write_u32((uint32_t) 1073887296U, (uint32_t) (n_r13 | (uint32_t) ((uint32_t) 1U << (uint32_t) 28U)));
    
    uint32_t n_r14 = ivory_hw_io_read_u32((uint32_t) 1073770496U);
    
    /* reg modify pwr_cr: setBit pwr_cr_vos */
    ivory_hw_io_write_u32((uint32_t) 1073770496U, (uint32_t) (n_r14 | (uint32_t) ((uint32_t) 1U << (uint32_t) 14U)));
    
    uint32_t n_r15 = ivory_hw_io_read_u32((uint32_t) 1073887240U);
    
    /* reg modify rcc_cfgr: setField rcc_cfgr_hpre, setField rcc_cfgr_ppre1, setField rcc_cfgr_ppre2 */
    ivory_hw_io_write_u32((uint32_t) 1073887240U, (uint32_t) ((uint32_t) (n_cse36 & (uint32_t) ((uint32_t) (n_cse41 & (uint32_t) (n_cse48 | (uint32_t) (n_cse46 & n_r15))) | (uint32_t) ((uint32_t) (uint8_t) ((uint8_t) 5U << 0) << (uint32_t) 10U))) | (uint32_t) ((uint32_t) (uint8_t) ((uint8_t) 4U << 0) << (uint32_t) 13U)));
    
    uint32_t n_r16 = ivory_hw_io_read_u32((uint32_t) 1073887236U);
    
    /* reg modify rcc_pllcfgr: setField rcc_pllcfgr_pllm, setField rcc_pllcfgr_plln, setField rcc_pllcfgr_pllp, setField rcc_pllcfgr_pllq */
    ivory_hw_io_write_u32((uint32_t) 1073887236U, (uint32_t) ((uint32_t) (n_cse67 & (uint32_t) (n_cse79 | (uint32_t) (n_cse77 & (uint32_t) ((uint32_t) (n_cse82 & (uint32_t) ((uint32_t) (n_cse89 & n_r16) | (uint32_t) ((uint32_t) 24U << 0))) | (uint32_t) ((uint32_t) 336U << (uint32_t) 6U))))) | (uint32_t) ((uint32_t) 7U << (uint32_t) 24U)));
    
    uint32_t n_r17 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
    
    /* reg modify rcc_cr: setBit rcc_cr_pll_on */
    ivory_hw_io_write_u32((uint32_t) 1073887232U, (uint32_t) (n_cse62 | n_r17));
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            /* reg get rcc_cr:  */
            ;
            
            uint32_t n_r18 = ivory_hw_io_read_u32((uint32_t) 1073887232U);
            
            if ((bool) (0 != (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r18 >> (uint32_t) 25U) & (uint32_t) 1U) & (uint16_t) 255U))) {
                break;
            }
        }
    }
    
    uint32_t n_r19 = ivory_hw_io_read_u32((uint32_t) 1073888256U);
    
    /* reg modify flash_acr: setBit flash_acr_ic_en, setBit flash_acr_dc_en, setField flash_acr_latency */
    ivory_hw_io_write_u32((uint32_t) 1073888256U, (uint32_t) ((uint32_t) ((uint32_t) ((uint32_t) (n_cse109 | n_cse112) | n_r19) & (uint32_t) ~(uint32_t) ((uint32_t) 7U << 0)) | (uint32_t) ((uint32_t) 5U << 0)));
    
    uint32_t n_r20 = ivory_hw_io_read_u32((uint32_t) 1073887240U);
    
    /* reg modify rcc_cfgr: setField rcc_cfgr_sw */
    ;
    
    uint8_t n_cse202 = (uint8_t) ((uint8_t) 2U << 0);
    
    ivory_hw_io_write_u32((uint32_t) 1073887240U, (uint32_t) ((uint32_t) (n_r20 & (uint32_t) ~(uint32_t) ((uint32_t) 3U << 0)) | (uint32_t) ((uint32_t) n_cse202 << 0)));
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) {
            /* reg get rcc_cfgr:  */
            ;
            
            uint32_t n_r21 = ivory_hw_io_read_u32((uint32_t) 1073887240U);
            
            if ((bool) (n_cse202 == (uint8_t) (uint16_t) ((uint16_t) (uint32_t) ((uint32_t) (n_r21 >> (uint32_t) 2U) & (uint32_t) 3U) & (uint16_t) 255U))) {
                break;
            }
        }
    }
}

void fatal(uint8_t n_var0)
{
    debug_print("FATAL ERROR: ");
    debug_printhex8(n_var0);
    debug_println("");
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) { }
    }
}

void main(void)
{
    init_clocks();
    clock_set_cpu_rate_in_hz((int64_t) 168000000);
    
    bool n_r0 = initialize_periodic_dispatcher();
    
    if ((bool) !n_r0) {
        debug_println("Unable to initialize periodic dispatcher.");
        fatal((uint8_t) -1U);
    }
    debug_println("Starting RTOS");
    rtos_start();
    {
        int forever_loop __attribute__((unused));
        
        for (forever_loop = 0; IFOREVER; IFOREVER_INC) { }
    }
}
