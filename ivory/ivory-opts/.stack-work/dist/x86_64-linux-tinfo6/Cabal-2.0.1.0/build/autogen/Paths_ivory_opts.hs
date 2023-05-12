{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_ivory_opts (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,5] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/bin"
libdir     = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/lib/x86_64-linux-ghc-8.2.2/ivory-opts-0.1.0.5-62liZqLvxFC9ILg3tq6vyM"
dynlibdir  = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/share/x86_64-linux-ghc-8.2.2/ivory-opts-0.1.0.5"
libexecdir = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/libexec/x86_64-linux-ghc-8.2.2/ivory-opts-0.1.0.5"
sysconfdir = "/home/x2/FlyCube/smaccmpilot-build/ivory-tower-stm32/.stack-work/install/x86_64-linux-tinfo6/48737a8025d618c7ad4bf67ae8685d9f433bcfc63bb29be2ecf006bd07f6e646/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ivory_opts_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ivory_opts_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ivory_opts_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ivory_opts_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ivory_opts_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ivory_opts_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
