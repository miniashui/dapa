{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.RebootMagic where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data RebootMagic
  = LinuxRebootMagic1
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum RebootMagic where
  toEnum 4276215469 = LinuxRebootMagic1
  toEnum _ = error "toEnum: invalid value for RebootMagic"
  fromEnum LinuxRebootMagic1 = 4276215469
putRebootMagic :: Putter RebootMagic
putRebootMagic LinuxRebootMagic1 = putWord32be 4276215469
getRebootMagic :: Get RebootMagic
getRebootMagic = do
  a <- getWord32be
  case a of
    4276215469 -> return LinuxRebootMagic1
    _ -> fail "invalid value in getRebootMagic"
instance Serialize RebootMagic where
  put = putRebootMagic
  get = getRebootMagic
arbitraryRebootMagic :: Q.Gen RebootMagic
arbitraryRebootMagic =
  Q.elements [ LinuxRebootMagic1
  ]
instance Q.Arbitrary RebootMagic where
  arbitrary = arbitraryRebootMagic
instance ToJSON RebootMagic
instance FromJSON RebootMagic