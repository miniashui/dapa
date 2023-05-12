{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.RcInput where
import Data.Word
import SMACCMPilot.Comm.Native.Types.TimeMicros
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data RcInput =
  RcInput
    { valid :: Bool
    , roll :: Word16
    , pitch :: Word16
    , throttle :: Word16
    , yaw :: Word16
    , switch1 :: Word16
    , switch2 :: Word16
    , time :: TimeMicros
    } deriving (Eq, Show, Data, Typeable, Generic)
putRcInput :: Putter RcInput
putRcInput RcInput{..} = do
  put valid
  putWord16be roll
  putWord16be pitch
  putWord16be throttle
  putWord16be yaw
  putWord16be switch1
  putWord16be switch2
  putTimeMicros time
getRcInput :: Get RcInput
getRcInput = do
  valid <- get
  roll <- getWord16be
  pitch <- getWord16be
  throttle <- getWord16be
  yaw <- getWord16be
  switch1 <- getWord16be
  switch2 <- getWord16be
  time <- getTimeMicros
  return RcInput{..}
instance Serialize RcInput where
  put = putRcInput
  get = getRcInput
arbitraryRcInput :: Q.Gen RcInput
arbitraryRcInput = do
  valid <- Q.arbitrary
  roll <- Q.arbitrary
  pitch <- Q.arbitrary
  throttle <- Q.arbitrary
  yaw <- Q.arbitrary
  switch1 <- Q.arbitrary
  switch2 <- Q.arbitrary
  time <- Q.arbitrary
  return RcInput{..}
instance Q.Arbitrary RcInput where
  arbitrary = arbitraryRcInput
instance ToJSON RcInput
instance FromJSON RcInput