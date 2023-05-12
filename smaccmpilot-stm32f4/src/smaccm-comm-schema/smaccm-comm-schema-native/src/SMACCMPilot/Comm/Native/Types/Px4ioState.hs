{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Px4ioState where
import SMACCMPilot.Comm.Native.Types.Px4ioStatus
import SMACCMPilot.Comm.Native.Types.Px4ioAlarms
import SMACCMPilot.Comm.Native.Types.RcInput
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Px4ioState =
  Px4ioState
    { comm_ok :: Bool
    , status :: Px4ioStatus
    , alarms :: Px4ioAlarms
    , rc_in :: RcInput
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putPx4ioState :: Putter Px4ioState
putPx4ioState Px4ioState{..} = do
  put comm_ok
  putPx4ioStatus status
  putPx4ioAlarms alarms
  putRcInput rc_in
  putTimeMicros time
getPx4ioState :: Get Px4ioState
getPx4ioState = do
  comm_ok <- get
  status <- getPx4ioStatus
  alarms <- getPx4ioAlarms
  rc_in <- getRcInput
  time <- getTimeMicros
  return Px4ioState{..}
instance Serialize Px4ioState where
  put = putPx4ioState
  get = getPx4ioState
arbitraryPx4ioState :: Q.Gen Px4ioState
arbitraryPx4ioState = do
  comm_ok <- Q.arbitrary
  status <- Q.arbitrary
  alarms <- Q.arbitrary
  rc_in <- Q.arbitrary
  time <- Q.arbitrary
  return Px4ioState{..}
instance Q.Arbitrary Px4ioState where
  arbitrary = arbitraryPx4ioState
instance ToJSON Px4ioState
instance FromJSON Px4ioState