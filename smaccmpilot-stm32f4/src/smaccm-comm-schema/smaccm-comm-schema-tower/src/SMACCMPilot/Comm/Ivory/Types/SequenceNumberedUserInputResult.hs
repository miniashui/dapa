{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInputResult where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.UserInputResult as UserInputResult
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_user_input_result
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct user_input_result
  }
|]
packSequenceNumberedUserInputResult :: WrappedPackRep ('Struct "sequence_numbered_user_input_result")
packSequenceNumberedUserInputResult = wrapPackRep "sequence_numbered_user_input_result" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_user_input_result") where
  packRep = wrappedPackRep packSequenceNumberedUserInputResult
sequenceNumberedUserInputResultTypesModule :: Module
sequenceNumberedUserInputResultTypesModule = package "sequence_numbered_user_input_result_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_user_input_result")
  depend serializeModule
  wrappedPackMod packSequenceNumberedUserInputResult
  depend SequenceNum.sequenceNumTypesModule
  depend UserInputResult.userInputResultTypesModule