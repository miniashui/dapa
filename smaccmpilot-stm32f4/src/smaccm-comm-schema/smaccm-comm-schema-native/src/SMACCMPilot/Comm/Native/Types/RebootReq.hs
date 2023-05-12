{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.RebootReq where
import SMACCMPilot.Comm.Native.Types.RebootMagic
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data RebootReq =
  RebootReq
    { magic :: RebootMagic
    } deriving (Eq, Show, Data, Typeable, Generic)
putRebootReq :: Putter RebootReq
putRebootReq RebootReq{..} = do
  putRebootMagic magic
getRebootReq :: Get RebootReq
getRebootReq = do
  magic <- getRebootMagic
  return RebootReq{..}
instance Serialize RebootReq where
  put = putRebootReq
  get = getRebootReq
arbitraryRebootReq :: Q.Gen RebootReq
arbitraryRebootReq = do
  magic <- Q.arbitrary
  return RebootReq{..}
instance Q.Arbitrary RebootReq where
  arbitrary = arbitraryRebootReq
instance ToJSON RebootReq
instance FromJSON RebootReq