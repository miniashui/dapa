{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ControlSetpoint where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ControlSetpoint =
  ControlSetpoint
    { altitude :: Float
    , alt_rate :: Float
    , roll :: Float
    , pitch :: Float
    , heading :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putControlSetpoint :: Putter ControlSetpoint
putControlSetpoint ControlSetpoint{..} = do
  putFloat32be altitude
  putFloat32be alt_rate
  putFloat32be roll
  putFloat32be pitch
  putFloat32be heading
getControlSetpoint :: Get ControlSetpoint
getControlSetpoint = do
  altitude <- getFloat32be
  alt_rate <- getFloat32be
  roll <- getFloat32be
  pitch <- getFloat32be
  heading <- getFloat32be
  return ControlSetpoint{..}
instance Serialize ControlSetpoint where
  put = putControlSetpoint
  get = getControlSetpoint
arbitraryControlSetpoint :: Q.Gen ControlSetpoint
arbitraryControlSetpoint = do
  altitude <- Q.arbitrary
  alt_rate <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  heading <- Q.arbitrary
  return ControlSetpoint{..}
instance Q.Arbitrary ControlSetpoint where
  arbitrary = arbitraryControlSetpoint
instance ToJSON ControlSetpoint
instance FromJSON ControlSetpoint