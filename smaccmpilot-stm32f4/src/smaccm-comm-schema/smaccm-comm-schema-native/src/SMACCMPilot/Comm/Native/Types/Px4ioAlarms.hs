{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Px4ioAlarms where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Px4ioAlarms =
  Px4ioAlarms
    { vservo_fault :: Bool
    , pwm_error :: Bool
    , rc_lost :: Bool
    , fmu_lost :: Bool
    , acc_current :: Bool
    , servo_current :: Bool
    , temperature :: Bool
    , vbatt_low :: Bool
    } deriving (Eq, Show, Data, Typeable, Generic)
putPx4ioAlarms :: Putter Px4ioAlarms
putPx4ioAlarms Px4ioAlarms{..} = do
  put vservo_fault
  put pwm_error
  put rc_lost
  put fmu_lost
  put acc_current
  put servo_current
  put temperature
  put vbatt_low
getPx4ioAlarms :: Get Px4ioAlarms
getPx4ioAlarms = do
  vservo_fault <- get
  pwm_error <- get
  rc_lost <- get
  fmu_lost <- get
  acc_current <- get
  servo_current <- get
  temperature <- get
  vbatt_low <- get
  return Px4ioAlarms{..}
instance Serialize Px4ioAlarms where
  put = putPx4ioAlarms
  get = getPx4ioAlarms
arbitraryPx4ioAlarms :: Q.Gen Px4ioAlarms
arbitraryPx4ioAlarms = do
  vservo_fault <- Q.arbitrary
  pwm_error <- Q.arbitrary
  rc_lost <- Q.arbitrary
  fmu_lost <- Q.arbitrary
  acc_current <- Q.arbitrary
  servo_current <- Q.arbitrary
  temperature <- Q.arbitrary
  vbatt_low <- Q.arbitrary
  return Px4ioAlarms{..}
instance Q.Arbitrary Px4ioAlarms where
  arbitrary = arbitraryPx4ioAlarms
instance ToJSON Px4ioAlarms
instance FromJSON Px4ioAlarms