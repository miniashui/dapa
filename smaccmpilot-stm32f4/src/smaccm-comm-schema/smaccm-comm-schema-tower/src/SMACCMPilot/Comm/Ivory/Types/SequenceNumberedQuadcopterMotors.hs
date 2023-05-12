{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedQuadcopterMotors where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.QuadcopterMotors as QuadcopterMotors
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_quadcopter_motors
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct quadcopter_motors
  }
|]
packSequenceNumberedQuadcopterMotors :: WrappedPackRep ('Struct "sequence_numbered_quadcopter_motors")
packSequenceNumberedQuadcopterMotors = wrapPackRep "sequence_numbered_quadcopter_motors" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_quadcopter_motors") where
  packRep = wrappedPackRep packSequenceNumberedQuadcopterMotors
sequenceNumberedQuadcopterMotorsTypesModule :: Module
sequenceNumberedQuadcopterMotorsTypesModule = package "sequence_numbered_quadcopter_motors_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_quadcopter_motors")
  depend serializeModule
  wrappedPackMod packSequenceNumberedQuadcopterMotors
  depend SequenceNum.sequenceNumTypesModule
  depend QuadcopterMotors.quadcopterMotorsTypesModule