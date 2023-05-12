{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.ControlSource where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data ControlSource
  = Ppm
  | Gcs
  | Nav
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum ControlSource where
  toEnum 0 = Ppm
  toEnum 1 = Gcs
  toEnum 2 = Nav
  toEnum _ = error "toEnum: invalid value for ControlSource"
  fromEnum Ppm = 0
  fromEnum Gcs = 1
  fromEnum Nav = 2
putControlSource :: Putter ControlSource
putControlSource Ppm = putWord8 0
putControlSource Gcs = putWord8 1
putControlSource Nav = putWord8 2
getControlSource :: Get ControlSource
getControlSource = do
  a <- getWord8
  case a of
    0 -> return Ppm
    1 -> return Gcs
    2 -> return Nav
    _ -> fail "invalid value in getControlSource"
instance Serialize ControlSource where
  put = putControlSource
  get = getControlSource
arbitraryControlSource :: Q.Gen ControlSource
arbitraryControlSource =
  Q.elements [ Ppm
             , Gcs
             , Nav
             ]
instance Q.Arbitrary ControlSource where
  arbitrary = arbitraryControlSource
instance ToJSON ControlSource
instance FromJSON ControlSource