{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

module Main where

import Ivory.Language
import Ivory.Tower
import Ivory.Tower.Config
import Ivory.OS.FreeRTOS.Tower.STM32

import SMACCMPilot.Comm.Tower.Interface.Vehicle.Producer
import SMACCMPilot.Comm.Tower.Interface.Vehicle.Consumer
import SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Producer
import SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Consumer

main :: IO ()
main = compileTowerSTM32FreeRTOS id p app
  where p topts = getConfig topts (stm32ConfigParser (stm32f405Defaults 24))

app :: Tower e ()
app = do
  (c :: (ChanInput ('Array 80 ('Stored Uint8)), ChanOutput ('Array 80 ('Stored Uint8)))) <- channel
  vehicleProducerInput (snd c) >>= \i -> vehicleProducerOutput i >>= \(_ :: ChanOutput ('Array 80 ('Stored Uint8))) -> return ()
  vehicleConsumerInput (snd c) >>= \i -> vehicleConsumerOutput i >>= \(_ :: ChanOutput ('Array 80 ('Stored Uint8))) -> return ()
  controllableVehicleProducerInput (snd c) >>= \i -> controllableVehicleProducerOutput i >>= \(_ :: ChanOutput ('Array 80 ('Stored Uint8))) -> return ()
  controllableVehicleConsumerInput (snd c) >>= \i -> controllableVehicleConsumerOutput i >>= \(_ :: ChanOutput ('Array 80 ('Stored Uint8))) -> return ()