{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.PidConfig where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data PidConfig =
  PidConfig
    { p_gain :: Float
    , i_gain :: Float
    , d_gain :: Float
    , dd_gain :: Float
    , i_min :: Float
    , i_max :: Float
    , err_max :: Float
    , errd_max :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putPidConfig :: Putter PidConfig
putPidConfig PidConfig{..} = do
  putFloat32be p_gain
  putFloat32be i_gain
  putFloat32be d_gain
  putFloat32be dd_gain
  putFloat32be i_min
  putFloat32be i_max
  putFloat32be err_max
  putFloat32be errd_max
getPidConfig :: Get PidConfig
getPidConfig = do
  p_gain <- getFloat32be
  i_gain <- getFloat32be
  d_gain <- getFloat32be
  dd_gain <- getFloat32be
  i_min <- getFloat32be
  i_max <- getFloat32be
  err_max <- getFloat32be
  errd_max <- getFloat32be
  return PidConfig{..}
instance Serialize PidConfig where
  put = putPidConfig
  get = getPidConfig
arbitraryPidConfig :: Q.Gen PidConfig
arbitraryPidConfig = do
  p_gain <- Q.arbitrary
  i_gain <- Q.arbitrary
  d_gain <- Q.arbitrary
  dd_gain <- Q.arbitrary
  i_min <- Q.arbitrary
  i_max <- Q.arbitrary
  err_max <- Q.arbitrary
  errd_max <- Q.arbitrary
  return PidConfig{..}
instance Q.Arbitrary PidConfig where
  arbitrary = arbitraryPidConfig
instance ToJSON PidConfig
instance FromJSON PidConfig