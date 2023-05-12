{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.GpsFix where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data GpsFix
  = FixNone
  | Fix2d
  | Fix3d
  deriving (Eq, Show, Ord, Data, Typeable, Generic)
instance Enum GpsFix where
  toEnum 0 = FixNone
  toEnum 2 = Fix2d
  toEnum 3 = Fix3d
  toEnum _ = error "toEnum: invalid value for GpsFix"
  fromEnum FixNone = 0
  fromEnum Fix2d = 2
  fromEnum Fix3d = 3
putGpsFix :: Putter GpsFix
putGpsFix FixNone = putWord8 0
putGpsFix Fix2d = putWord8 2
putGpsFix Fix3d = putWord8 3
getGpsFix :: Get GpsFix
getGpsFix = do
  a <- getWord8
  case a of
    0 -> return FixNone
    2 -> return Fix2d
    3 -> return Fix3d
    _ -> fail "invalid value in getGpsFix"
instance Serialize GpsFix where
  put = putGpsFix
  get = getGpsFix
arbitraryGpsFix :: Q.Gen GpsFix
arbitraryGpsFix =
  Q.elements [ FixNone
             , Fix2d
             , Fix3d
             ]
instance Q.Arbitrary GpsFix where
  arbitrary = arbitraryGpsFix
instance ToJSON GpsFix
instance FromJSON GpsFix