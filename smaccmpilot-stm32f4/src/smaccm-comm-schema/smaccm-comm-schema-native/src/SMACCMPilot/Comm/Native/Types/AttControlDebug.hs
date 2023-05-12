{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.AttControlDebug where
import SMACCMPilot.Comm.Native.Types.PidState
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data AttControlDebug =
  AttControlDebug
    { head_setpt :: Float
    , head_rate_est :: Float
    , head_rate_setpt :: Float
    , head_ctl_p :: Float
    , head_ctl_d :: Float
    , pitch_setpt :: Float
    , pitch_rate_setpt :: Float
    , roll_setpt :: Float
    , roll_rate_setpt :: Float
    , att_pid :: PidState
    } deriving (Eq, Show, Data, Typeable, Generic)
putAttControlDebug :: Putter AttControlDebug
putAttControlDebug AttControlDebug{..} = do
  putFloat32be head_setpt
  putFloat32be head_rate_est
  putFloat32be head_rate_setpt
  putFloat32be head_ctl_p
  putFloat32be head_ctl_d
  putFloat32be pitch_setpt
  putFloat32be pitch_rate_setpt
  putFloat32be roll_setpt
  putFloat32be roll_rate_setpt
  putPidState att_pid
getAttControlDebug :: Get AttControlDebug
getAttControlDebug = do
  head_setpt <- getFloat32be
  head_rate_est <- getFloat32be
  head_rate_setpt <- getFloat32be
  head_ctl_p <- getFloat32be
  head_ctl_d <- getFloat32be
  pitch_setpt <- getFloat32be
  pitch_rate_setpt <- getFloat32be
  roll_setpt <- getFloat32be
  roll_rate_setpt <- getFloat32be
  att_pid <- getPidState
  return AttControlDebug{..}
instance Serialize AttControlDebug where
  put = putAttControlDebug
  get = getAttControlDebug
arbitraryAttControlDebug :: Q.Gen AttControlDebug
arbitraryAttControlDebug = do
  head_setpt <- Q.arbitrary
  head_rate_est <- Q.arbitrary
  head_rate_setpt <- Q.arbitrary
  head_ctl_p <- Q.arbitrary
  head_ctl_d <- Q.arbitrary
  pitch_setpt <- Q.arbitrary
  pitch_rate_setpt <- Q.arbitrary
  roll_setpt <- Q.arbitrary
  roll_rate_setpt <- Q.arbitrary
  att_pid <- Q.arbitrary
  return AttControlDebug{..}
instance Q.Arbitrary AttControlDebug where
  arbitrary = arbitraryAttControlDebug
instance ToJSON AttControlDebug
instance FromJSON AttControlDebug