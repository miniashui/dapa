{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Tristate where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Tristate
  = Negative
  | Neutral
  | Positive
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum Tristate where
  toEnum 0 = Negative
  toEnum 1 = Neutral
  toEnum 2 = Positive
  toEnum _ = error "toEnum: invalid value for Tristate"
  fromEnum Negative = 0
  fromEnum Neutral = 1
  fromEnum Positive = 2
putTristate :: Putter Tristate
putTristate Negative = putWord8 0
putTristate Neutral = putWord8 1
putTristate Positive = putWord8 2
getTristate :: Get Tristate
getTristate = do
  a <- getWord8
  case a of
    0 -> return Negative
    1 -> return Neutral
    2 -> return Positive
    _ -> fail "invalid value in getTristate"
instance Serialize Tristate where
  put = putTristate
  get = getTristate
arbitraryTristate :: Q.Gen Tristate
arbitraryTristate =
  Q.elements [ Negative
             , Neutral
             , Positive
             ]
instance Q.Arbitrary Tristate where
  arbitrary = arbitraryTristate
instance ToJSON Tristate
instance FromJSON Tristate