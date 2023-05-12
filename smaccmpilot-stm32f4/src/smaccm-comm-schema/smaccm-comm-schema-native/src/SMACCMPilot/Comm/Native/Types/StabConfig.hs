{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.StabConfig where
import SMACCMPilot.Comm.Native.Types.PidConfig
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data StabConfig =
  StabConfig
    { pos :: PidConfig
    , rate :: PidConfig
    } deriving (Eq, Show, Data, Typeable, Generic)
putStabConfig :: Putter StabConfig
putStabConfig StabConfig{..} = do
  putPidConfig pos
  putPidConfig rate
getStabConfig :: Get StabConfig
getStabConfig = do
  pos <- getPidConfig
  rate <- getPidConfig
  return StabConfig{..}
instance Serialize StabConfig where
  put = putStabConfig
  get = getStabConfig
arbitraryStabConfig :: Q.Gen StabConfig
arbitraryStabConfig = do
  pos <- Q.arbitrary
  rate <- Q.arbitrary
  return StabConfig{..}
instance Q.Arbitrary StabConfig where
  arbitrary = arbitraryStabConfig
instance ToJSON StabConfig
instance FromJSON StabConfig