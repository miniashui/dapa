{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Px4ioStatus where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Px4ioStatus =
  Px4ioStatus
    { safety_off :: Bool
    , failsafe :: Bool
    , init_ok :: Bool
    , arm_sync :: Bool
    , mixer_ok :: Bool
    , raw_pwm :: Bool
    , fmu_ok :: Bool
    , rc_sbus :: Bool
    , rc_dsm :: Bool
    , rc_ppm :: Bool
    , rc_ok :: Bool
    , outputs_armed :: Bool
    , override :: Bool
    } deriving (Eq, Show, Data, Typeable, Generic)
putPx4ioStatus :: Putter Px4ioStatus
putPx4ioStatus Px4ioStatus{..} = do
  put safety_off
  put failsafe
  put init_ok
  put arm_sync
  put mixer_ok
  put raw_pwm
  put fmu_ok
  put rc_sbus
  put rc_dsm
  put rc_ppm
  put rc_ok
  put outputs_armed
  put override
getPx4ioStatus :: Get Px4ioStatus
getPx4ioStatus = do
  safety_off <- get
  failsafe <- get
  init_ok <- get
  arm_sync <- get
  mixer_ok <- get
  raw_pwm <- get
  fmu_ok <- get
  rc_sbus <- get
  rc_dsm <- get
  rc_ppm <- get
  rc_ok <- get
  outputs_armed <- get
  override <- get
  return Px4ioStatus{..}
instance Serialize Px4ioStatus where
  put = putPx4ioStatus
  get = getPx4ioStatus
arbitraryPx4ioStatus :: Q.Gen Px4ioStatus
arbitraryPx4ioStatus = do
  safety_off <- Q.arbitrary
  failsafe <- Q.arbitrary
  init_ok <- Q.arbitrary
  arm_sync <- Q.arbitrary
  mixer_ok <- Q.arbitrary
  raw_pwm <- Q.arbitrary
  fmu_ok <- Q.arbitrary
  rc_sbus <- Q.arbitrary
  rc_dsm <- Q.arbitrary
  rc_ppm <- Q.arbitrary
  rc_ok <- Q.arbitrary
  outputs_armed <- Q.arbitrary
  override <- Q.arbitrary
  return Px4ioStatus{..}
instance Q.Arbitrary Px4ioStatus where
  arbitrary = arbitraryPx4ioStatus
instance ToJSON Px4ioStatus
instance FromJSON Px4ioStatus