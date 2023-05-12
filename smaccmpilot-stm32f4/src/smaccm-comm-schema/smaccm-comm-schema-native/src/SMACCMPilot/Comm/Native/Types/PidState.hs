{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module SMACCMPilot.Comm.Native.Types.PidState where
import Data.Aeson (ToJSON,FromJSON)
import Data.Serialize
import Data.Typeable
import Data.Data
import GHC.Generics (Generic)
import qualified Test.QuickCheck as Q
data PidState =
  PidState
    { i_state :: Float
    , d_term :: Float
    , dd_term :: Float
    , p_term :: Float
    , i_term :: Float
    , angle_err :: Float
    , rate_err :: Float
    } deriving (Eq, Show, Data, Typeable, Generic)
putPidState :: Putter PidState
putPidState PidState{..} = do
  putFloat32be i_state
  putFloat32be d_term
  putFloat32be dd_term
  putFloat32be p_term
  putFloat32be i_term
  putFloat32be angle_err
  putFloat32be rate_err
getPidState :: Get PidState
getPidState = do
  i_state <- getFloat32be
  d_term <- getFloat32be
  dd_term <- getFloat32be
  p_term <- getFloat32be
  i_term <- getFloat32be
  angle_err <- getFloat32be
  rate_err <- getFloat32be
  return PidState{..}
instance Serialize PidState where
  put = putPidState
  get = getPidState
arbitraryPidState :: Q.Gen PidState
arbitraryPidState = do
  i_state <- Q.arbitrary
  d_term <- Q.arbitrary
  dd_term <- Q.arbitrary
  p_term <- Q.arbitrary
  i_term <- Q.arbitrary
  angle_err <- Q.arbitrary
  rate_err <- Q.arbitrary
  return PidState{..}
instance Q.Arbitrary PidState where
  arbitrary = arbitraryPidState
instance ToJSON PidState
instance FromJSON PidState