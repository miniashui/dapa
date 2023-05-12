{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ControlOutput where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ControlOutput =
  ControlOutput
    { armed :: Bool
    , throttle :: Float
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putControlOutput :: Putter ControlOutput
putControlOutput ControlOutput{..} = do
  put armed
  putFloat32be throttle
  putFloat32be roll
  putFloat32be pitch
  putFloat32be yaw
getControlOutput :: Get ControlOutput
getControlOutput = do
  armed <- get
  throttle <- getFloat32be
  roll <- getFloat32be
  pitch <- getFloat32be
  yaw <- getFloat32be
  return ControlOutput{..}
instance Serialize ControlOutput where
  put = putControlOutput
  get = getControlOutput
arbitraryControlOutput :: Q.Gen ControlOutput
arbitraryControlOutput = do
  armed <- Q.arbitrary
  throttle <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  yaw <- Q.arbitrary
  return ControlOutput{..}
instance Q.Arbitrary ControlOutput where
  arbitrary = arbitraryControlOutput
instance ToJSON ControlOutput
instance FromJSON ControlOutput