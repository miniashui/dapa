{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.PidState where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct pid_state
  { i_state :: (Stored IFloat)
  ; d_term :: (Stored IFloat)
  ; dd_term :: (Stored IFloat)
  ; p_term :: (Stored IFloat)
  ; i_term :: (Stored IFloat)
  ; angle_err :: (Stored IFloat)
  ; rate_err :: (Stored IFloat)
  }
|]
packPidState :: WrappedPackRep ('Struct "pid_state")
packPidState = wrapPackRep "pid_state" $
  packStruct [ packLabel i_state
             , packLabel d_term
             , packLabel dd_term
             , packLabel p_term
             , packLabel i_term
             , packLabel angle_err
             , packLabel rate_err
             ]
instance Packable ('Struct "pid_state") where
  packRep = wrappedPackRep packPidState
pidStateTypesModule :: Module
pidStateTypesModule = package "pid_state_types" $ do
  defStruct (Proxy :: Proxy "pid_state")
  depend serializeModule
  wrappedPackMod packPidState