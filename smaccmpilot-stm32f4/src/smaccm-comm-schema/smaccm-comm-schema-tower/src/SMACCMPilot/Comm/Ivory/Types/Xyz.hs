{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.Xyz where
import Ivory.Language
import Ivory.Serialize
[ivory|
struct xyz
  { x :: (Stored IFloat)
  ; y :: (Stored IFloat)
  ; z :: (Stored IFloat)
  }
|]
packXyz :: WrappedPackRep ('Struct "xyz")
packXyz = wrapPackRep "xyz" $
  packStruct [ packLabel x
             , packLabel y
             , packLabel z
             ]
instance Packable ('Struct "xyz") where
  packRep = wrappedPackRep packXyz
xyzTypesModule :: Module
xyzTypesModule = package "xyz_types" $ do
  defStruct (Proxy :: Proxy "xyz")
  depend serializeModule
  wrappedPackMod packXyz