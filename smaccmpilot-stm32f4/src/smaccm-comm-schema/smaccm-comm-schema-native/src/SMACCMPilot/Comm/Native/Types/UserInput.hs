{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.UserInput where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data UserInput =
  UserInput
    { throttle :: Float
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putUserInput :: Putter UserInput
putUserInput UserInput{..} = do
  putFloat32be throttle
  putFloat32be roll
  putFloat32be pitch
  putFloat32be yaw
getUserInput :: Get UserInput
getUserInput = do
  throttle <- getFloat32be
  roll <- getFloat32be
  pitch <- getFloat32be
  yaw <- getFloat32be
  return UserInput{..}
instance Serialize UserInput where
  put = putUserInput
  get = getUserInput
arbitraryUserInput :: Q.Gen UserInput
arbitraryUserInput = do
  throttle <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  yaw <- Q.arbitrary
  return UserInput{..}
instance Q.Arbitrary UserInput where
  arbitrary = arbitraryUserInput
instance ToJSON UserInput
instance FromJSON UserInput