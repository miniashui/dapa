{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ControlModes where
import SMACCMPilot.Comm.Native.Types.ControlSource
import SMACCMPilot.Comm.Native.Types.YawMode
import SMACCMPilot.Comm.Native.Types.ThrottleMode
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ControlModes =
  ControlModes
    { ui_mode :: ControlSource
    , yaw_mode :: YawMode
    , thr_mode :: ThrottleMode
    } deriving (Eq, Show, Data, Typeable, Generic)
putControlModes :: Putter ControlModes
putControlModes ControlModes{..} = do
  putControlSource ui_mode
  putYawMode yaw_mode
  putThrottleMode thr_mode
getControlModes :: Get ControlModes
getControlModes = do
  ui_mode <- getControlSource
  yaw_mode <- getYawMode
  thr_mode <- getThrottleMode
  return ControlModes{..}
instance Serialize ControlModes where
  put = putControlModes
  get = getControlModes
arbitraryControlModes :: Q.Gen ControlModes
arbitraryControlModes = do
  ui_mode <- Q.arbitrary
  yaw_mode <- Q.arbitrary
  thr_mode <- Q.arbitrary
  return ControlModes{..}
instance Q.Arbitrary ControlModes where
  arbitrary = arbitraryControlModes
instance ToJSON ControlModes
instance FromJSON ControlModes