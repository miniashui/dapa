{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ArmingStatus where
import SMACCMPilot.Comm.Native.Types.Tristate
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ArmingStatus =
  ArmingStatus
    { rcinput :: Tristate
    , telem :: Tristate
    , px4io :: Tristate
    , sens_valid :: Tristate
    } deriving (Eq, Show, Data, Typeable, Generic)
putArmingStatus :: Putter ArmingStatus
putArmingStatus ArmingStatus{..} = do
  putTristate rcinput
  putTristate telem
  putTristate px4io
  putTristate sens_valid
getArmingStatus :: Get ArmingStatus
getArmingStatus = do
  rcinput <- getTristate
  telem <- getTristate
  px4io <- getTristate
  sens_valid <- getTristate
  return ArmingStatus{..}
instance Serialize ArmingStatus where
  put = putArmingStatus
  get = getArmingStatus
arbitraryArmingStatus :: Q.Gen ArmingStatus
arbitraryArmingStatus = do
  rcinput <- Q.arbitrary
  telem <- Q.arbitrary
  px4io <- Q.arbitrary
  sens_valid <- Q.arbitrary
  return ArmingStatus{..}
instance Q.Arbitrary ArmingStatus where
  arbitrary = arbitraryArmingStatus
instance ToJSON ArmingStatus
instance FromJSON ArmingStatus