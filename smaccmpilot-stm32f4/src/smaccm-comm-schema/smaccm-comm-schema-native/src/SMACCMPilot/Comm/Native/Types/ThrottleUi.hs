{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ThrottleUi where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ThrottleUi =
  ThrottleUi
    { sens :: Float
    , dead :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putThrottleUi :: Putter ThrottleUi
putThrottleUi ThrottleUi{..} = do
  putFloat32be sens
  putFloat32be dead
getThrottleUi :: Get ThrottleUi
getThrottleUi = do
  sens <- getFloat32be
  dead <- getFloat32be
  return ThrottleUi{..}
instance Serialize ThrottleUi where
  put = putThrottleUi
  get = getThrottleUi
arbitraryThrottleUi :: Q.Gen ThrottleUi
arbitraryThrottleUi = do
  sens <- Q.arbitrary
  dead <- Q.arbitrary
  return ThrottleUi{..}
instance Q.Arbitrary ThrottleUi where
  arbitrary = arbitraryThrottleUi
instance ToJSON ThrottleUi
instance FromJSON ThrottleUi