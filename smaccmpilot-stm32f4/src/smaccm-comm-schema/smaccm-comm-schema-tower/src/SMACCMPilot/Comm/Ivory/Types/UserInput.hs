{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.UserInput where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct user_input
  { throttle :: (Stored IFloat)
  ; roll :: (Stored IFloat)
  ; pitch :: (Stored IFloat)
  ; yaw :: (Stored IFloat)
  }
|]
packUserInput :: WrappedPackRep ('Struct "user_input")
packUserInput = wrapPackRep "user_input" $
  packStruct [ packLabel throttle
             , packLabel roll
             , packLabel pitch
             , packLabel yaw
             ]
instance Packable ('Struct "user_input") where
  packRep = wrappedPackRep packUserInput
userInputTypesModule :: Module
userInputTypesModule = package "user_input_types" $ do
  defStruct (Proxy :: Proxy "user_input")
  depend serializeModule
  wrappedPackMod packUserInput