{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_tower_mini (
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
version = Version [0,0,1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/bin"
libdir     = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/lib/x86_64-linux-ghc-8.2.2/tower-mini-0.0.1.0-FLkojHdcP8K7ASLJXycOB-integrated"
dynlibdir  = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/share/x86_64-linux-ghc-8.2.2/tower-mini-0.0.1.0"
libexecdir = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/libexec/x86_64-linux-ghc-8.2.2/tower-mini-0.0.1.0"
sysconfdir = "/home/x2/FlyCube/smaccmpilot-build/smaccmpilot-stm32f4/.stack-work/install/x86_64-linux-tinfo6/34572729e3e25b673b2b81dea3f7f84440d3a9965eefca17d5b65b72e8dbdbbe/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tower_mini_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tower_mini_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "tower_mini_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "tower_mini_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tower_mini_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tower_mini_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
