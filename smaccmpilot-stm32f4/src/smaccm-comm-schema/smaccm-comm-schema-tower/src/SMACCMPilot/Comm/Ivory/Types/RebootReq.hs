{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.RebootReq where
import qualified SMACCMPilot.Comm.Ivory.Types.RebootMagic as RebootMagic
import Ivory.Language
import Ivory.Serialize
[ivory|
struct reboot_req
  { magic :: (Stored RebootMagic.RebootMagic)
  }
|]
packRebootReq :: WrappedPackRep ('Struct "reboot_req")
packRebootReq = wrapPackRep "reboot_req" $
  packStruct [ packLabel magic
             ]
instance Packable ('Struct "reboot_req") where
  packRep = wrappedPackRep packRebootReq
rebootReqTypesModule :: Module
rebootReqTypesModule = package "reboot_req_types" $ do
  defStruct (Proxy :: Proxy "reboot_req")
  depend serializeModule
  wrappedPackMod packRebootReq
  depend RebootMagic.rebootMagicTypesModule