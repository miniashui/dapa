{-# LANGUAGE CPP #-}

module Ivory.Tower.AST.Period where

#if MIN_VERSION_mainland_pretty(0,6,0)
import           Text.PrettyPrint.Mainland.Class
#endif
import Text.PrettyPrint.Mainland

import qualified Ivory.Language.Syntax.Type as I

import Ivory.Tower.Types.Time

data Period = Period
  { period_dt    :: Microseconds
  , period_ty    :: I.Type
  , period_phase :: Microseconds
  } deriving (Eq, Show, Ord)

instance Pretty Period where
  ppr p = text (prettyTime (period_dt p))
