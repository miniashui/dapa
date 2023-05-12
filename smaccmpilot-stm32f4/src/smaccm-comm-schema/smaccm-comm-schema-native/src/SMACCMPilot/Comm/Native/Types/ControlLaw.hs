{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ControlLaw where
import SMACCMPilot.Comm.Native.Types.ArmingMode
import SMACCMPilot.Comm.Native.Types.ControlModes
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ControlLaw =
  ControlLaw
    { arming_mode :: ArmingMode
    , control_modes :: ControlModes
    } deriving (Eq, Show, Data, Typeable, Generic)
putControlLaw :: Putter ControlLaw
putControlLaw ControlLaw{..} = do
  putArmingMode arming_mode
  putControlModes control_modes
getControlLaw :: Get ControlLaw
getControlLaw = do
  arming_mode <- getArmingMode
  control_modes <- getControlModes
  return ControlLaw{..}
instance Serialize ControlLaw where
  put = putControlLaw
  get = getControlLaw
arbitraryControlLaw :: Q.Gen ControlLaw
arbitraryControlLaw = do
  arming_mode <- Q.arbitrary
  control_modes <- Q.arbitrary
  return ControlLaw{..}
instance Q.Arbitrary ControlLaw where
  arbitrary = arbitraryControlLaw
instance ToJSON ControlLaw
instance FromJSON ControlLaw