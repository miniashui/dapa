{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.UserInputResult where
import qualified SMACCMPilot.Comm.Ivory.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import Ivory.Language
import Ivory.Serialize
[ivory|
struct user_input_result
  { ui :: Struct user_input
  ; source :: (Stored ControlSource.ControlSource)
  ; time :: (Stored TimeMicros.TimeMicros)
  }
|]
packUserInputResult :: WrappedPackRep ('Struct "user_input_result")
packUserInputResult = wrapPackRep "user_input_result" $
  packStruct [ packLabel ui
             , packLabel source
             , packLabel time
             ]
instance Packable ('Struct "user_input_result") where
  packRep = wrappedPackRep packUserInputResult
userInputResultTypesModule :: Module
userInputResultTypesModule = package "user_input_result_types" $ do
  defStruct (Proxy :: Proxy "user_input_result")
  depend serializeModule
  wrappedPackMod packUserInputResult
  depend UserInput.userInputTypesModule
  depend ControlSource.controlSourceTypesModule
  depend TimeMicros.timeMicrosTypesModule