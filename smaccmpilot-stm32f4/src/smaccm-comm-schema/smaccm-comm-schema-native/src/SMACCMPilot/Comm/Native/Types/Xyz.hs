{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.Xyz where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data Xyz =
  Xyz
    { x :: Float
    , y :: Float
    , z :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putXyz :: Putter Xyz
putXyz Xyz{..} = do
  putFloat32be x
  putFloat32be y
  putFloat32be z
getXyz :: Get Xyz
getXyz = do
  x <- getFloat32be
  y <- getFloat32be
  z <- getFloat32be
  return Xyz{..}
instance Serialize Xyz where
  put = putXyz
  get = getXyz
arbitraryXyz :: Q.Gen Xyz
arbitraryXyz = do
  x <- Q.arbitrary
  y <- Q.arbitrary
  z <- Q.arbitrary
  return Xyz{..}
instance Q.Arbitrary Xyz where
  arbitrary = arbitraryXyz
instance ToJSON Xyz
instance FromJSON Xyz