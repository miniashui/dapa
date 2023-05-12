{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.UserInputResult where
import SMACCMPilot.Comm.Native.Types.UserInput
import SMACCMPilot.Comm.Native.Types.ControlSource
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data UserInputResult =
  UserInputResult
    { ui :: UserInput
    , source :: ControlSource
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putUserInputResult :: Putter UserInputResult
putUserInputResult UserInputResult{..} = do
  putUserInput ui
  putControlSource source
  putTimeMicros time
getUserInputResult :: Get UserInputResult
getUserInputResult = do
  ui <- getUserInput
  source <- getControlSource
  time <- getTimeMicros
  return UserInputResult{..}
instance Serialize UserInputResult where
  put = putUserInputResult
  get = getUserInputResult
arbitraryUserInputResult :: Q.Gen UserInputResult
arbitraryUserInputResult = do
  ui <- Q.arbitrary
  source <- Q.arbitrary
  time <- Q.arbitrary
  return UserInputResult{..}
instance Q.Arbitrary UserInputResult where
  arbitrary = arbitraryUserInputResult
instance ToJSON UserInputResult
instance FromJSON UserInputResult