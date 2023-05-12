{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ThrottleMode where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ThrottleMode
  = DirectUi
  | AltUi
  | AltSetpt
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum ThrottleMode where
  toEnum 0 = DirectUi
  toEnum 1 = AltUi
  toEnum 2 = AltSetpt
  toEnum _ = error "toEnum: invalid value for ThrottleMode"
  fromEnum DirectUi = 0
  fromEnum AltUi = 1
  fromEnum AltSetpt = 2
putThrottleMode :: Putter ThrottleMode
putThrottleMode DirectUi = putWord8 0
putThrottleMode AltUi = putWord8 1
putThrottleMode AltSetpt = putWord8 2
getThrottleMode :: Get ThrottleMode
getThrottleMode = do
  a <- getWord8
  case a of
    0 -> return DirectUi
    1 -> return AltUi
    2 -> return AltSetpt
    _ -> fail "invalid value in getThrottleMode"
instance Serialize ThrottleMode where
  put = putThrottleMode
  get = getThrottleMode
arbitraryThrottleMode :: Q.Gen ThrottleMode
arbitraryThrottleMode =
  Q.elements [ DirectUi
             , AltUi
             , AltSetpt
             ]
instance Q.Arbitrary ThrottleMode where
  arbitrary = arbitraryThrottleMode
instance ToJSON ThrottleMode
instance FromJSON ThrottleMode