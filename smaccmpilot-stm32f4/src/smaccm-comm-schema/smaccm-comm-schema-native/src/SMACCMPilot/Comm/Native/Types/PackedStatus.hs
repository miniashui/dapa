{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.PackedStatus where
import SMACCMPilot.Comm.Native.Types.GpsFix
import Data.Word
import Data.Int
import SMACCMPilot.Comm.Native.Types.Tristate
import SMACCMPilot.Comm.Native.Types.ArmingMode
import SMACCMPilot.Comm.Native.Types.ControlModes
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data PackedStatus =
  PackedStatus
    { valid :: Bool
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    , alt_est :: Float
    , fix :: GpsFix
    , num_sv :: Word8
    , lat :: Int32
    , lon :: Int32
    , alt :: Int32
    , vground :: Word32
    , heading :: Float
    , rcinput :: Tristate
    , telem :: Tristate
    , px4io :: Tristate
    , sens_valid :: Tristate
    , arming_mode :: ArmingMode
    , control_modes :: ControlModes
    , battery_voltage :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putPackedStatus :: Putter PackedStatus
putPackedStatus PackedStatus{..} = do
  put valid
  putFloat32be roll
  putFloat32be pitch
  putFloat32be yaw
  putFloat32be alt_est
  putGpsFix fix
  putWord8 num_sv
  put lat
  put lon
  put alt
  putWord32be vground
  putFloat32be heading
  putTristate rcinput
  putTristate telem
  putTristate px4io
  putTristate sens_valid
  putArmingMode arming_mode
  putControlModes control_modes
  putFloat32be battery_voltage
getPackedStatus :: Get PackedStatus
getPackedStatus = do
  valid <- get
  roll <- getFloat32be
  pitch <- getFloat32be
  yaw <- getFloat32be
  alt_est <- getFloat32be
  fix <- getGpsFix
  num_sv <- getWord8
  lat <- get
  lon <- get
  alt <- get
  vground <- getWord32be
  heading <- getFloat32be
  rcinput <- getTristate
  telem <- getTristate
  px4io <- getTristate
  sens_valid <- getTristate
  arming_mode <- getArmingMode
  control_modes <- getControlModes
  battery_voltage <- getFloat32be
  return PackedStatus{..}
instance Serialize PackedStatus where
  put = putPackedStatus
  get = getPackedStatus
arbitraryPackedStatus :: Q.Gen PackedStatus
arbitraryPackedStatus = do
  valid <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  yaw <- Q.arbitrary
  alt_est <- Q.arbitrary
  fix <- Q.arbitrary
  num_sv <- Q.arbitrary
  lat <- Q.arbitrary
  lon <- Q.arbitrary
  alt <- Q.arbitrary
  vground <- Q.arbitrary
  heading <- Q.arbitrary
  rcinput <- Q.arbitrary
  telem <- Q.arbitrary
  px4io <- Q.arbitrary
  sens_valid <- Q.arbitrary
  arming_mode <- Q.arbitrary
  control_modes <- Q.arbitrary
  battery_voltage <- Q.arbitrary
  return PackedStatus{..}
instance Q.Arbitrary PackedStatus where
  arbitrary = arbitraryPackedStatus
instance ToJSON PackedStatus
instance FromJSON PackedStatus