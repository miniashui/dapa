{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE CPP #-}

--
-- Map the Tower AST into the AADL AST.
--
-- (c) 2014 Galois, Inc.
--

module Tower.AADL.Config where

import           Data.List
import           Data.Char (toUpper)
import           Ivory.Tower.Options (TOpts(..))
import           Ivory.Tower.Config
import qualified System.Console.GetOpt as O
import qualified System.Directory as D

import           Tower.AADL.Platform (OS(..), HW(..))
import           Tower.AADL.Priorities (PriorityMap, emptyPriorityMap)

----------------------------------------

data AADLConfig = AADLConfig
  { configSrcsDir        :: FilePath
  -- ^ Location of/to put C sources relative to genDirOpts.
  , configHdrDir         :: FilePath
  -- ^ Location of/to put C headers relative to genDirOpts.
  , configLibDir         :: FilePath
  -- ^ Location of/to put C lib sources relative to genDirOpts.
  , configSystemName     :: String
  -- ^ System name.
  , configSystemOS       :: OS
  -- ^ Operating system name.
  , configSystemHW       :: HW
  -- ^ HW name.
  , configSystemAddr     :: Maybe Integer
  -- ^ Flash load address
  , configPriorities     :: PriorityMap
  -- ^ Priorities for threads.
  , configCustomMakefile :: Bool
  -- ^ If True, user provides custom Makefile.
  , configCustomKConfig  :: Bool
  -- ^ If True, user provides custom Kconfig, Kbuild.
  , configRamsesPath     :: Maybe FilePath
  -- ^ Location of Ramses jar executable. Nothing means it's in the path.
  , configEchronosPath   :: Maybe FilePath
  -- ^ Location of eChronos.
  }
  deriving (Show)

defaultAADLConfig :: AADLConfig
defaultAADLConfig = AADLConfig
  { configSrcsDir         = "user_code"
  , configHdrDir          = "include"
  , configLibDir          = "smaccmpilot"
  , configSystemName      = "sys"
  , configSystemOS        = CAmkES
  , configSystemHW        = QEMU
  , configSystemAddr      = Nothing
  , configPriorities      = emptyPriorityMap
  , configCustomMakefile  = False
  , configCustomKConfig   = False
  , configRamsesPath      = Nothing
  , configEchronosPath    = Nothing
  }

lib :: AADLConfig -> String
lib c = "lib" ++ configLibDir c

aadlConfigParser :: AADLConfig -> ConfigParser AADLConfig
aadlConfigParser dflt = subsection "aadl" p `withDefault` dflt
  where
  p = do
    os   <- (subsection "os" osParser)   `withDefault` (configSystemOS   dflt)
    hw   <- (subsection "os" hwParser)   `withDefault` (configSystemHW   dflt)
    addr <- (subsection "os" addrParser) `withDefault` (configSystemAddr dflt)
    return dflt { configSystemOS = os, configSystemHW = hw, configSystemAddr = addr }
  osParser = string >>= \s ->
    case map toUpper s of
      "CAMKES"   -> return CAmkES
      "ECHRONOS" -> return EChronos
      _ -> fail ("expected AADL OS, got " ++ s)
  hwParser = string >>= \s ->
    case map toUpper s of
      "QEMU"    -> return QEMU
      "ODROID"  -> return ODROID
      "PIXHAWK" -> return PIXHAWK
      _ -> fail ("expected AADL HW Platform, got " ++ s)
  addrParser = integer >>= \i -> return (Just i)

----------------------------------------
-- Additional command line opts

data Flag = LibDir String
  deriving (Show, Read, Eq)

options :: [O.OptDescr Flag]
options =
  [ O.Option "" ["lib-dir"] (O.ReqArg LibDir "DIR") "library directory name" ]

parseAADLOpts :: AADLConfig -> TOpts -> (AADLConfig, [String], [String])
parseAADLOpts c topts = (foldl' go c flags, nonOpts, errs)
  where
  (flags, nonOpts, errs) = O.getOpt O.Permute options (topts_args topts)
  go c' (LibDir dir) = c' { configLibDir = dir }

-- Turn relative paths into absolute paths.
makeAbsPaths :: AADLConfig -> IO AADLConfig
makeAbsPaths cfg = do
  rp  <- mkAbsFP (configRamsesPath cfg)
  cep <- mkAbsFP (configEchronosPath cfg)
  return cfg { configRamsesPath   = rp
             , configEchronosPath = cep
             }

mkAbsFP :: Maybe FilePath -> IO (Maybe FilePath)
mkAbsFP mfp =
  case mfp of
    Nothing -> return Nothing
#if __GLASGOW_HASKELL__ <= 784
    Just fp -> Just `fmap` D.canonicalizePath fp
#else
    Just fp -> Just `fmap` D.makeAbsolute fp
#endif

maybeFP :: Maybe FilePath -> String
maybeFP = maybe "" id
