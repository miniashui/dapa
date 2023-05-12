{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInput where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.UserInput as UserInput
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_user_input
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct user_input
  }
|]
packSequenceNumberedUserInput :: WrappedPackRep ('Struct "sequence_numbered_user_input")
packSequenceNumberedUserInput = wrapPackRep "sequence_numbered_user_input" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_user_input") where
  packRep = wrappedPackRep packSequenceNumberedUserInput
sequenceNumberedUserInputTypesModule :: Module
sequenceNumberedUserInputTypesModule = package "sequence_numbered_user_input_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_user_input")
  depend serializeModule
  wrappedPackMod packSequenceNumberedUserInput
  depend SequenceNum.sequenceNumTypesModule
  depend UserInput.userInputTypesModule