{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ArmingMode where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ArmingMode
  = Safe
  | Armed
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum ArmingMode where
  toEnum 0 = Safe
  toEnum 1 = Armed
  toEnum _ = error "toEnum: invalid value for ArmingMode"
  fromEnum Safe = 0
  fromEnum Armed = 1
putArmingMode :: Putter ArmingMode
putArmingMode Safe = putWord8 0
putArmingMode Armed = putWord8 1
getArmingMode :: Get ArmingMode
getArmingMode = do
  a <- getWord8
  case a of
    0 -> return Safe
    1 -> return Armed
    _ -> fail "invalid value in getArmingMode"
instance Serialize ArmingMode where
  put = putArmingMode
  get = getArmingMode
arbitraryArmingMode :: Q.Gen ArmingMode
arbitraryArmingMode =
  Q.elements [ Safe
             , Armed
             ]
instance Q.Arbitrary ArmingMode where
  arbitrary = arbitraryArmingMode
instance ToJSON ArmingMode
instance FromJSON ArmingMode