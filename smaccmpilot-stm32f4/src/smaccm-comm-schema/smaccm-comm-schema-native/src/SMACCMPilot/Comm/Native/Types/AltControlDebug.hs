{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.AltControlDebug where
import SMACCMPilot.Comm.Native.Types.PidState
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data AltControlDebug =
  AltControlDebug
    { alt_est :: Float
    , alt_rate_est :: Float
    , r22_gain :: Float
    , ui_setp :: Float
    , ui_rate_setp :: Float
    , pos :: PidState
    , vz_fb :: Float
    , vz_ff :: Float
    , vz_ff_rot :: Float
    , vz_ctl :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putAltControlDebug :: Putter AltControlDebug
putAltControlDebug AltControlDebug{..} = do
  putFloat32be alt_est
  putFloat32be alt_rate_est
  putFloat32be r22_gain
  putFloat32be ui_setp
  putFloat32be ui_rate_setp
  putPidState pos
  putFloat32be vz_fb
  putFloat32be vz_ff
  putFloat32be vz_ff_rot
  putFloat32be vz_ctl
getAltControlDebug :: Get AltControlDebug
getAltControlDebug = do
  alt_est <- getFloat32be
  alt_rate_est <- getFloat32be
  r22_gain <- getFloat32be
  ui_setp <- getFloat32be
  ui_rate_setp <- getFloat32be
  pos <- getPidState
  vz_fb <- getFloat32be
  vz_ff <- getFloat32be
  vz_ff_rot <- getFloat32be
  vz_ctl <- getFloat32be
  return AltControlDebug{..}
instance Serialize AltControlDebug where
  put = putAltControlDebug
  get = getAltControlDebug
arbitraryAltControlDebug :: Q.Gen AltControlDebug
arbitraryAltControlDebug = do
  alt_est <- Q.arbitrary
  alt_rate_est <- Q.arbitrary
  r22_gain <- Q.arbitrary
  ui_setp <- Q.arbitrary
  ui_rate_setp <- Q.arbitrary
  pos <- Q.arbitrary
  vz_fb <- Q.arbitrary
  vz_ff <- Q.arbitrary
  vz_ff_rot <- Q.arbitrary
  vz_ctl <- Q.arbitrary
  return AltControlDebug{..}
instance Q.Arbitrary AltControlDebug where
  arbitrary = arbitraryAltControlDebug
instance ToJSON AltControlDebug
instance FromJSON AltControlDebug