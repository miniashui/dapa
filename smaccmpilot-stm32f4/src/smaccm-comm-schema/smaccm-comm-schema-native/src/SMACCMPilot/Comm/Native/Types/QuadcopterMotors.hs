{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.QuadcopterMotors where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data QuadcopterMotors =
  QuadcopterMotors
    { frontleft :: Float
    , frontright :: Float
    , backleft :: Float
    , backright :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putQuadcopterMotors :: Putter QuadcopterMotors
putQuadcopterMotors QuadcopterMotors{..} = do
  putFloat32be frontleft
  putFloat32be frontright
  putFloat32be backleft
  putFloat32be backright
getQuadcopterMotors :: Get QuadcopterMotors
getQuadcopterMotors = do
  frontleft <- getFloat32be
  frontright <- getFloat32be
  backleft <- getFloat32be
  backright <- getFloat32be
  return QuadcopterMotors{..}
instance Serialize QuadcopterMotors where
  put = putQuadcopterMotors
  get = getQuadcopterMotors
arbitraryQuadcopterMotors :: Q.Gen QuadcopterMotors
arbitraryQuadcopterMotors = do
  frontleft <- Q.arbitrary
  frontright <- Q.arbitrary
  backleft <- Q.arbitrary
  backright <- Q.arbitrary
  return QuadcopterMotors{..}
instance Q.Arbitrary QuadcopterMotors where
  arbitrary = arbitraryQuadcopterMotors
instance ToJSON QuadcopterMotors
instance FromJSON QuadcopterMotors