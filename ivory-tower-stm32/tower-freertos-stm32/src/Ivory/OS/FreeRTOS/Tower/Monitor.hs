{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module Ivory.OS.FreeRTOS.Tower.Monitor
  ( generateMonitorCode
  , monitorInitProc
  , monitorLockProc
  , monitorUnlockProc
  , monitorStateModName
  , monitorGenModName
  , monitorLockProcName
  , monitorUnlockProcName
  ) where

import Ivory.Tower.Types.Dependencies

import qualified Ivory.Tower.AST as AST

import Ivory.Language
import qualified Ivory.OS.FreeRTOS.Mutex as Mutex

monitorStateModName :: AST.Monitor -> String
monitorStateModName mon = "tower_state_monitor_" ++ AST.monitorName mon

monitorGenModName :: AST.Monitor -> String
monitorGenModName mon = "tower_gen_monitor_" ++ AST.monitorName mon

generateMonitorCode :: Dependencies
                    -> (AST.Monitor, ModuleDef)
                    -> [Module]
generateMonitorCode d (mon, moddef)  =
  [ package (monitorStateModName mon) $ do
      dependencies
      moddef
  , package (monitorGenModName mon) $ do
      dependencies
      gen_pkg
  ]
  where
  dependencies = mapM_ depend (dependencies_depends d)
  gen_pkg = do
    Mutex.moddef
    defMemArea (monitorLockArea mon)
    incl (monitorInitProc mon)
    incl (monitorLockProc mon)
    incl (monitorUnlockProc mon)

monitorLockName :: AST.Monitor -> String
monitorLockName mon = "lock_"  ++ AST.monitorName mon

monitorLockArea :: AST.Monitor -> MemArea Mutex.Mutex
monitorLockArea mon = area (monitorLockName mon) Nothing

monitorLock :: AST.Monitor -> Mutex.MutexHandle
monitorLock mon = addrOf (monitorLockArea mon)

monitorInitProc :: AST.Monitor -> Def('[]':->())
monitorInitProc mon = proc n $ body $
  call_ Mutex.create (monitorLock mon)
  where
  n = "monitor_init_" ++ AST.monitorName mon

monitorUnlockProc :: AST.Monitor -> Def('[]':->())
monitorUnlockProc mon = proc (monitorUnlockProcName mon) $ body $
  call_ Mutex.give (monitorLock mon)

monitorLockProc :: AST.Monitor -> Def('[]':->())
monitorLockProc mon = proc (monitorLockProcName mon) $ body $
  call_ Mutex.take (monitorLock mon)

monitorUnlockProcName :: AST.Monitor -> String
monitorUnlockProcName mon = "monitor_unlock_" ++ AST.monitorName mon

monitorLockProcName :: AST.Monitor -> String
monitorLockProcName mon = "monitor_lock_" ++ AST.monitorName mon

