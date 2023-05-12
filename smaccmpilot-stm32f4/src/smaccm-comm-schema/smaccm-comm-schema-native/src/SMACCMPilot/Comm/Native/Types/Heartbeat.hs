{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Heartbeat where
import SMACCMPilot.Comm.Native.Types.TimeMicros
import SMACCMPilot.Comm.Native.Types.ArmingMode
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Heartbeat =
  Heartbeat
    { time :: TimeMicros
    , arming_mode :: ArmingMode
    } deriving (Eq, Show, Data, Typeable, Generic)
putHeartbeat :: Putter Heartbeat
putHeartbeat Heartbeat{..} = do
  putTimeMicros time
  putArmingMode arming_mode
getHeartbeat :: Get Heartbeat
getHeartbeat = do
  time <- getTimeMicros
  arming_mode <- getArmingMode
  return Heartbeat{..}
instance Serialize Heartbeat where
  put = putHeartbeat
  get = getHeartbeat
arbitraryHeartbeat :: Q.Gen Heartbeat
arbitraryHeartbeat = do
  time <- Q.arbitrary
  arming_mode <- Q.arbitrary
  return Heartbeat{..}
instance Q.Arbitrary Heartbeat where
  arbitrary = arbitraryHeartbeat
instance ToJSON Heartbeat
instance FromJSON Heartbeat