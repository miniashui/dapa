
--
-- MemoryMap.hs -- Memory map (addresses) for STM32F427
--
-- Copyright (C) 2014, Galois, Inc.
-- All Rights Reserved.
--

module Ivory.BSP.STM32F427.MemoryMap where

import Ivory.BSP.STM32.MemoryMap

flash_base, ccmdataram_base, sram1_base, sram2_base :: Integer
flash_base      = 0x08000000
ccmdataram_base = 0x10000000
sram1_base      = 0x20000000
sram2_base      = 0x2001C000

bkpsram_base :: Integer
bkpsram_base = 0x40024000

--- APB1 Peripherals
tim2_periph_base :: Integer
tim2_periph_base = apb1_periph_base + 0x0000
tim3_periph_base :: Integer
tim3_periph_base = apb1_periph_base + 0x0400
tim4_periph_base :: Integer
tim4_periph_base = apb1_periph_base + 0x0800
tim5_periph_base :: Integer
tim5_periph_base = apb1_periph_base + 0x0C00
tim6_periph_base :: Integer
tim6_periph_base = apb1_periph_base + 0x1000
tim7_periph_base :: Integer
tim7_periph_base = apb1_periph_base + 0x1400
tim12_periph_base :: Integer
tim12_periph_base = apb1_periph_base + 0x1800
tim13_periph_base :: Integer
tim13_periph_base = apb1_periph_base + 0x1C00
tim14_periph_base :: Integer
tim14_periph_base = apb1_periph_base + 0x2000
rtc_periph_base :: Integer
rtc_periph_base = apb1_periph_base + 0x2800
wwdg_periph_base :: Integer
wwdg_periph_base = apb1_periph_base + 0x2C00
iwdg_periph_base :: Integer
iwdg_periph_base = apb1_periph_base + 0x3000
i2s2ext_periph_base :: Integer
i2s2ext_periph_base = apb1_periph_base + 0x3400
spi2_periph_base :: Integer
spi2_periph_base = apb1_periph_base + 0x3800
spi3_periph_base :: Integer
spi3_periph_base = apb1_periph_base + 0x3C00
i2s3ext_periph_base :: Integer
i2s3ext_periph_base = apb1_periph_base + 0x4000
uart2_periph_base :: Integer
uart2_periph_base = apb1_periph_base + 0x4400
uart3_periph_base :: Integer
uart3_periph_base = apb1_periph_base + 0x4800
uart4_periph_base :: Integer
uart4_periph_base = apb1_periph_base + 0x4C00
uart5_periph_base :: Integer
uart5_periph_base = apb1_periph_base + 0x5000
i2c1_periph_base :: Integer
i2c1_periph_base = apb1_periph_base + 0x5400
i2c2_periph_base :: Integer
i2c2_periph_base = apb1_periph_base + 0x5800
i2c3_periph_base :: Integer
i2c3_periph_base = apb1_periph_base + 0x5C00
can1_periph_base :: Integer
can1_periph_base = apb1_periph_base + 0x6400
can2_periph_base :: Integer
can2_periph_base = apb1_periph_base + 0x6800
--pwr_periph_base :: Integer
--pwr_periph_base = apb1_periph_base + 0x7000
dac_periph_base :: Integer
dac_periph_base = apb1_periph_base + 0x7400
uart7_periph_base :: Integer
uart7_periph_base = apb1_periph_base + 0x7800
uart8_periph_base :: Integer
uart8_periph_base = apb1_periph_base + 0x7C00


-- APB2 Peripherals
tim1_periph_base :: Integer
tim1_periph_base = apb2_periph_base + 0x0000
tim8_periph_base :: Integer
tim8_periph_base = apb2_periph_base + 0x0400
uart1_periph_base :: Integer
uart1_periph_base = apb2_periph_base + 0x1000
uart6_periph_base :: Integer
uart6_periph_base = apb2_periph_base + 0x1400
adc1_periph_base :: Integer
adc1_periph_base = apb2_periph_base + 0x2000
adc2_periph_base :: Integer
adc2_periph_base = apb2_periph_base + 0x2100
adc3_periph_base :: Integer
adc3_periph_base = apb2_periph_base + 0x2200
adc_periph_base :: Integer
adc_periph_base = apb2_periph_base + 0x2300
sdio_periph_base :: Integer
sdio_periph_base = apb2_periph_base + 0x2C00
spi1_periph_base :: Integer
spi1_periph_base = apb2_periph_base + 0x3000
spi4_periph_base :: Integer
spi4_periph_base = apb2_periph_base + 0x3400
syscfg_periph_base :: Integer
syscfg_periph_base = apb2_periph_base + 0x3800
exti_periph_base :: Integer
exti_periph_base = apb2_periph_base + 0x3C00
tim9_periph_base :: Integer
tim9_periph_base = apb2_periph_base + 0x4000
tim10_periph_base :: Integer
tim10_periph_base = apb2_periph_base + 0x4400
tim11_periph_base :: Integer
tim11_periph_base = apb2_periph_base + 0x4800
spi5_periph_base :: Integer
spi5_periph_base = apb2_periph_base + 0x5000
spi6_periph_base :: Integer
spi6_periph_base = apb2_periph_base + 0x5400
sai1_periph_base :: Integer
sai1_periph_base = apb2_periph_base + 0x5800
lcdtft_periph_base :: Integer
lcdtft_periph_base = apb2_periph_base + 0x6800


-- AHB1 Peripherals
gpioa_periph_base :: Integer
gpioa_periph_base = ahb1_periph_base + 0x0000
gpiob_periph_base :: Integer
gpiob_periph_base = ahb1_periph_base + 0x0400
gpioc_periph_base :: Integer
gpioc_periph_base = ahb1_periph_base + 0x0800
gpiod_periph_base :: Integer
gpiod_periph_base = ahb1_periph_base + 0x0C00
gpioe_periph_base :: Integer
gpioe_periph_base = ahb1_periph_base + 0x1000
gpiof_periph_base :: Integer
gpiof_periph_base = ahb1_periph_base + 0x1400
gpiog_periph_base :: Integer
gpiog_periph_base = ahb1_periph_base + 0x1800
gpioh_periph_base :: Integer
gpioh_periph_base = ahb1_periph_base + 0x1C00
gpioi_periph_base :: Integer
gpioi_periph_base = ahb1_periph_base + 0x2000
gpioj_periph_base :: Integer
gpioj_periph_base = ahb1_periph_base + 0x2400
gpiok_periph_base :: Integer
gpiok_periph_base = ahb1_periph_base + 0x2800
crc_periph_base :: Integer
crc_periph_base = ahb1_periph_base + 0x3000
-- skipping rcc_periph_base and flash_r_periph_base:
-- These are the same across the whole STM32 line, so we
-- declare them in Ivory.BSP.STM32.MemoryMap
dma1_periph_base :: Integer
dma1_periph_base = ahb1_periph_base + 0x6000
dma2_periph_base :: Integer
dma2_periph_base = ahb1_periph_base + 0x6400
eth_periph_base :: Integer
eth_periph_base = ahb1_periph_base + 0x8000
dma2d_periph_base :: Integer
dma2d_periph_base = ahb1_periph_base + 0xB000
usbotg_hs_periph_base :: Integer
usbotg_hs_periph_base = ahb1_periph_base + 0x20000


-- AHB2 peripherals 
usbotg_fs_periph_base :: Integer
usbotg_fs_periph_base = ahb2_periph_base
dcmi_periph_base :: Integer
dcmi_periph_base = ahb2_periph_base + 0x50000
cryp_periph_base :: Integer
cryp_periph_base = ahb2_periph_base + 0x60000
hash_periph_base :: Integer
hash_periph_base = ahb2_periph_base + 0x60400
rng_periph_base :: Integer
rng_periph_base = ahb2_periph_base + 0x60800

