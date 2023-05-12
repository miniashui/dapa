{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.QuadcopterMotors where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct quadcopter_motors
  { frontleft :: (Stored IFloat)
  ; frontright :: (Stored IFloat)
  ; backleft :: (Stored IFloat)
  ; backright :: (Stored IFloat)
  }
|]
packQuadcopterMotors :: WrappedPackRep ('Struct "quadcopter_motors")
packQuadcopterMotors = wrapPackRep "quadcopter_motors" $
  packStruct [ packLabel frontleft
             , packLabel frontright
             , packLabel backleft
             , packLabel backright
             ]
instance Packable ('Struct "quadcopter_motors") where
  packRep = wrappedPackRep packQuadcopterMotors
quadcopterMotorsTypesModule :: Module
quadcopterMotorsTypesModule = package "quadcopter_motors_types" $ do
  defStruct (Proxy :: Proxy "quadcopter_motors")
  depend serializeModule
  wrappedPackMod packQuadcopterMotors