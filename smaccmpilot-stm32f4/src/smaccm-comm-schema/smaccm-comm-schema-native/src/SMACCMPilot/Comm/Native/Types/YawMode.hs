{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.YawMode where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data YawMode
  = Rate
  | Heading
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum YawMode where
  toEnum 0 = Rate
  toEnum 1 = Heading
  toEnum _ = error "toEnum: invalid value for YawMode"
  fromEnum Rate = 0
  fromEnum Heading = 1
putYawMode :: Putter YawMode
putYawMode Rate = putWord8 0
putYawMode Heading = putWord8 1
getYawMode :: Get YawMode
getYawMode = do
  a <- getWord8
  case a of
    0 -> return Rate
    1 -> return Heading
    _ -> fail "invalid value in getYawMode"
instance Serialize YawMode where
  put = putYawMode
  get = getYawMode
arbitraryYawMode :: Q.Gen YawMode
arbitraryYawMode =
  Q.elements [ Rate
             , Heading
             ]
instance Q.Arbitrary YawMode where
  arbitrary = arbitraryYawMode
instance ToJSON YawMode
instance FromJSON YawMode