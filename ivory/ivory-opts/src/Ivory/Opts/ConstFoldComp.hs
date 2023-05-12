{-# LANGUAGE ViewPatterns #-}

--
-- Constant folding computations in Haskell.
--
-- Copyright (C) 2014, Galois, Inc.
-- All rights reserved.
--

module Ivory.Opts.ConstFoldComp
  ( CfVal(..)
  , err
  , toExpr
  , destLit
  , destBoolLit
  , destIntegerLit
  , isLitValue
  , mkCfArgs
  , cfNum
  , cfBitAnd
  , cfBitOr
  , cfFloating
  , cfFloatingB
  , cfIntOp2
  ) where

import qualified Ivory.Language.Syntax.AST as I
import qualified Ivory.Language.Syntax.Type as I
import Ivory.Language.Cast (toMaxSize, toMinSize)

import Control.Monad (mzero,msum)
import Data.Bits
import Data.Maybe

import Data.Word
import Data.Int

--------------------------------------------------------------------------------

-- | Constant-folded values.
data CfVal
  = CfBool Bool
  -- Is this a max or min value for the size type?
  | CfInteger MaxMin Integer
  | CfFloat Float
  | CfDouble Double
  | CfExpr I.Expr
    deriving (Show, Eq)

-- | Convert back to an expression.
toExpr :: CfVal -> I.Expr
toExpr val = case val of
  CfBool b      -> I.ExpLit (I.LitBool b)
  CfInteger m i -> case m of
    Min  -> I.ExpMaxMin False
    Max  -> I.ExpMaxMin True
    None -> I.ExpLit (I.LitInteger i)
  CfFloat f     -> I.ExpLit (I.LitFloat f)
  CfDouble d    -> I.ExpLit (I.LitDouble d)
  CfExpr ex     -> ex

--------------------------------------------------------------------------------

-- | Whether the bounded integer represents a max or min value for its size.
data MaxMin = Max | Min | None deriving (Show, Read, Eq)

isMaxMin :: I.Type -> Integer -> MaxMin
isMaxMin ty i
  | Just m <- toMaxSize ty
  , m == i
  = Max
  | Just m <- toMinSize ty
  , m == i
  = Min
  | otherwise
  = None

toMaxMin :: (Eq a, Bounded a) => a -> MaxMin
toMaxMin r | r == maxBound = Max
           | r == minBound = Min
           | otherwise     = None

--------------------------------------------------------------------------------

mkCfArgs :: I.Type -> [I.Expr] -> [CfVal]
mkCfArgs ty exps = map toCfVal exps
  where
  -- | Convert to a constant-folded value.  Picks the one successful lit, if any.
  toCfVal :: I.Expr -> CfVal
  toCfVal ex = fromMaybe (CfExpr ex) $ msum
    [ CfBool    `fmap` destBoolLit       ex
    , CfFloat   `fmap` destFloatLit      ex
    , CfDouble  `fmap` destDoubleLit     ex
    , (uncurry CfInteger) `fmap` (destMinMaxIntegerLit ex)
    ]

  -- | Minimum, maximum, or integer value.
  destMinMaxIntegerLit :: I.Expr -> Maybe (MaxMin, Integer)
  destMinMaxIntegerLit ex = case ex of
    I.ExpMaxMin True          -> do s <- toMaxSize ty
                                    return (Max, s)
    I.ExpMaxMin False         -> do s <- toMinSize ty
                                    return (Min, s)
    I.ExpLit (I.LitInteger i) -> Just (isMaxMin ty i, i)
    _                         -> Nothing


cfBitAnd :: I.Type -> [CfVal] -> CfVal
cfBitAnd ty [l, r] = case (ty, l, r) of
  (I.TyWord _, CfInteger Min _, _) -> l
  (I.TyWord _, CfInteger Max _, _) -> r
  (I.TyWord _, _, CfInteger Min _) -> r
  (I.TyWord _, _, CfInteger Max _) -> l
  _ -> abc (combineBits (.&.)) ty I.ExpBitAnd l r
cfBitAnd _ _ = err "Wrong number of args to cfBitAnd in constant folder."

cfBitOr :: I.Type -> [CfVal] -> CfVal
cfBitOr ty [l, r] = case (ty, l, r) of
  (I.TyWord _, CfInteger Min _, _) -> r
  (I.TyWord _, CfInteger Max _, _) -> l
  (I.TyWord _, _, CfInteger Min _) -> l
  (I.TyWord _, _, CfInteger Max _) -> r
  _ -> abc (combineBits (.|.)) ty I.ExpBitOr l r
cfBitOr _ _ = err "Wrong number of args to cfBitOr in constant folder."


combineBits :: (Integer -> Integer -> Integer) -> I.ExpOp -> CfVal -> CfVal -> CfVal
combineBits f _ (CfInteger _ x) (CfInteger _ y) = CfInteger None $ f x y
combineBits _ op x y = CfExpr $ I.ExpOp op [toExpr x, toExpr y]

--------------------------------------------------------------------------------

----------------------------------------
-- Gather constants from an associative/commutative tree of operators

{-
Rules for normalizing constants in Associative Binary Commutative operators:

op [const, const]: evaluate the op. (establishes that each op has at least one non-const child)
op [const, var] -> cf op [var, const] (allowed by commutativity; establishes that consts are only right-children)
op [a, op [b, c]] -> cf op [cf op [a, b], c] (allowed by associativity; establishes that right child is not this op, so can't contain more constants)
op [op [var, const], const] -> op [var, cf op [const, const]] (allowed by associativity; establishes that if right-child is const, left-child does not contain any constants)
op [op [var1, const], var2] -> op [op [var1, var2], const] (allowed by associativity and commutativity; establishes that left-child does not contain constants; note that var1 and var2 can't contain constants by these rules)
anything else: unchanged

These rules assume that the operands have already had these rules
applied bottom-up, and avoid re-doing any work in subtrees that haven't
changed.
-}

abc :: (I.ExpOp -> CfVal -> CfVal -> CfVal) -> I.Type -> I.ExpOp -> CfVal -> CfVal -> CfVal
abc combine ty op (CfExpr lhs) rhs = case (lhs, rhs) of
  (_, CfExpr (I.ExpOp op' (mkCfArgs ty -> [b, c]))) | op == op' -> abc combine ty op (abc combine ty op (CfExpr lhs) b) c
  (I.ExpOp _ (_ : (mkCfArgs ty -> [CfExpr _])), _) -> noop
  (I.ExpOp op' [a, b], CfExpr c) | op == op' -> CfExpr (I.ExpOp op [I.ExpOp op [a, c], b])
  (I.ExpOp op' (a : (mkCfArgs ty -> [b])), c) | op == op' -> CfExpr (I.ExpOp op [a, toExpr $ combine op b c])
  _ -> noop
  where
  noop = CfExpr (I.ExpOp op [lhs, toExpr rhs])
abc combine ty op lhs rhs@(CfExpr _) = abc combine ty op rhs lhs
abc combine _ op lhs rhs = combine op lhs rhs

--------------------------------------------------------------------------------

----------------------------------------
-- Constant folded Haskell literals

-- | Literal expression destructor.
destLit :: I.Expr -> Maybe I.Literal
destLit ex = case ex of
  I.ExpLit lit -> return lit
  _            -> mzero

-- | Boolean literal destructor.
destBoolLit :: I.Expr -> Maybe Bool
destBoolLit ex = do
  I.LitBool b <- destLit ex
  return b

-- | Integer literal destructor.
destIntegerLit :: I.Expr -> Maybe Integer
destIntegerLit ex = do
  I.LitInteger i <- destLit ex
  return i

-- | Float literal destructor.
destFloatLit :: I.Expr -> Maybe Float
destFloatLit ex = do
  I.LitFloat i <- destLit ex
  return i

-- | Double literal destructor.
destDoubleLit :: I.Expr -> Maybe Double
destDoubleLit ex = do
  I.LitDouble i <- destLit ex
  return i

isLitValue :: Integer -> CfVal -> Bool
isLitValue v (CfInteger _ v') = v == v'
isLitValue v (CfFloat v') = fromInteger v == v'
isLitValue v (CfDouble v') = fromInteger v == v'
isLitValue _ _ = False
----------------------------------------


class (Bounded a, Integral a) => IntegralOp a where
  appI1 :: (a -> a) -> a -> CfVal
  appI1 op x = let r = op x in
               CfInteger (toMaxMin r) (toInteger r)

  appI2 :: (a -> a -> a) -> a -> a -> CfVal
  appI2 op x y = let r = op x y in
                 CfInteger (toMaxMin r) (toInteger r)

instance IntegralOp Int8
instance IntegralOp Int16
instance IntegralOp Int32
instance IntegralOp Int64
instance IntegralOp Word8
instance IntegralOp Word16
instance IntegralOp Word32
instance IntegralOp Word64

--------------------------------------------------------------------------------

cfNum :: I.Type
      -> I.ExpOp
      -> [CfVal]
      -> CfVal
cfNum ty op args = case args of
  [x]   -> case x of
    CfInteger _ l -> case ty of
      I.TyInt isz -> case isz of
        I.Int8        -> appI1 op1 (fromInteger l :: Int8)
        I.Int16       -> appI1 op1 (fromInteger l :: Int16)
        I.Int32       -> appI1 op1 (fromInteger l :: Int32)
        I.Int64       -> appI1 op1 (fromInteger l :: Int64)
      I.TyWord isz -> case isz of
        I.Word8       -> appI1 op1 (fromInteger l :: Word8)
        I.Word16      -> appI1 op1 (fromInteger l :: Word16)
        I.Word32      -> appI1 op1 (fromInteger l :: Word32)
        I.Word64      -> appI1 op1 (fromInteger l :: Word64)
      I.TyIndex _n    -> appI1 op1 (fromInteger l :: Int32)
      _ -> err $ "bad type to cfNum loc 1 "
    CfFloat   l -> CfFloat   (op1 l)
    CfDouble  l -> CfDouble  (op1 l)
    _           -> CfExpr    (I.ExpOp op [toExpr x])

  [x,y] -> case (x,y) of
    (CfInteger _ l, CfInteger _ r) -> case ty of
      I.TyInt isz -> case isz of
        I.Int8        -> appI2 op2 (fromInteger l :: Int8)
                                   (fromInteger r :: Int8)
        I.Int16       -> appI2 op2 (fromInteger l :: Int16)
                                   (fromInteger r :: Int16)
        I.Int32       -> appI2 op2 (fromInteger l :: Int32)
                                   (fromInteger r :: Int32)
        I.Int64       -> appI2 op2 (fromInteger l :: Int64)
                                   (fromInteger r :: Int64)
      I.TyWord isz -> case isz of
        I.Word8       -> appI2 op2 (fromInteger l :: Word8)
                                   (fromInteger r :: Word8)
        I.Word16      -> appI2 op2 (fromInteger l :: Word16)
                                   (fromInteger r :: Word16)
        I.Word32      -> appI2 op2 (fromInteger l :: Word32)
                                   (fromInteger r :: Word32)
        I.Word64      -> appI2 op2 (fromInteger l :: Word64)
                                   (fromInteger r :: Word64)
      I.TyIndex _n    -> appI2 op2 (fromInteger l :: Int32)
                                   (fromInteger r :: Int32)
      _ -> err "bad type to cfNum loc 2"
    (CfFloat   l, CfFloat r)   -> CfFloat   (op2 l r)
    (CfDouble l,  CfDouble r)  -> CfDouble  (op2 l r)
    _                          -> CfExpr    (I.ExpOp op [toExpr x, toExpr y])

  _ -> err "wrong num args to cfNum"
  where
  op2 :: Num a => a -> a -> a
  op2 = case op of
    I.ExpMul    -> (*)
    I.ExpAdd    -> (+)
    I.ExpSub    -> (-)
    _ -> err "bad op to cfNum loc 3"
  op1 :: Num a => a -> a
  op1 = case op of
    I.ExpNegate -> negate
    I.ExpAbs    -> abs
    I.ExpSignum -> signum
    _ -> err "bad op to cfNum loc 4"

cfIntOp2 :: I.Type -> I.ExpOp -> [CfVal] -> CfVal
cfIntOp2 ty iOp [CfInteger _ l, CfInteger _ r] = case ty of
  I.TyInt isz -> case isz of
    I.Int8        -> appI2 op2 (fromInteger l :: Int8)
                               (fromInteger r :: Int8)
    I.Int16       -> appI2 op2 (fromInteger l :: Int16)
                               (fromInteger r :: Int16)
    I.Int32       -> appI2 op2 (fromInteger l :: Int32)
                               (fromInteger r :: Int32)
    I.Int64       -> appI2 op2 (fromInteger l :: Int64)
                               (fromInteger r :: Int64)
  I.TyWord isz -> case isz of
    I.Word8       -> appI2 op2 (fromInteger l :: Word8)
                               (fromInteger r :: Word8)
    I.Word16      -> appI2 op2 (fromInteger l :: Word16)
                               (fromInteger r :: Word16)
    I.Word32      -> appI2 op2 (fromInteger l :: Word32)
                               (fromInteger r :: Word32)
    I.Word64      -> appI2 op2 (fromInteger l :: Word64)
                               (fromInteger r :: Word64)
  I.TyIndex _n    -> appI2 op2 (fromInteger l :: Int32)
                               (fromInteger r :: Int32)
  _ -> err "bad type to cfIntOp2 loc 1"

  where
  op2 :: Integral a => a -> a -> a
  op2 = case iOp of
    I.ExpDiv -> quot
    -- Haskell's `rem` matches C ISO 1999 semantics of the remainder having the
    -- same sign as the dividend.
    I.ExpMod -> rem
    _ -> err "bad op to cfIntOp2"

cfIntOp2 _ iOp [x, y] = CfExpr (I.ExpOp iOp [toExpr x, toExpr y])
cfIntOp2 _ _ _        = err "wrong number of args to cfOp2"

--------------------------------------------------------------------------------

-- | Constant folding for unary operations that require a floating instance.
cfFloating :: I.ExpOp
           -> [CfVal]
           -> CfVal
cfFloating op args = case args of
  [x]   -> case x of
             CfFloat f  -> CfFloat  (op1 f)
             CfDouble d -> CfDouble (op1 d)
             _          -> CfExpr   (I.ExpOp op [toExpr x])
  [x,y] -> case (x,y) of
             (CfFloat l,  CfFloat r)  -> CfFloat (op2 l r)
             (CfDouble l, CfDouble r) -> CfDouble (op2 l r)
             _                        -> CfExpr   (I.ExpOp op [toExpr x
                                                              , toExpr y])
  _     -> err "wrong number of args to cfFloating"
  where
  op1 :: Floating a => a -> a
  op1 = case op of
    I.ExpRecip   -> recip
    I.ExpFExp    -> exp
    I.ExpFSqrt   -> sqrt
    I.ExpFLog    -> log
    I.ExpFSin    -> sin
    I.ExpFCos    -> cos
    I.ExpFTan    -> tan
    I.ExpFAsin   -> asin
    I.ExpFAcos   -> acos
    I.ExpFAtan   -> atan
    I.ExpFSinh   -> sinh
    I.ExpFCosh   -> cosh
    I.ExpFTanh   -> tanh
    I.ExpFAsinh  -> asinh
    I.ExpFAcosh  -> acosh
    I.ExpFAtanh  -> atanh
    _            -> err "wrong op1 to cfFloating"

  op2 :: RealFloat a => a -> a -> a
  op2 = case op of
    I.ExpFPow     -> (**)
    I.ExpFLogBase -> logBase
    I.ExpFAtan2   -> atan2
    _            -> err "wrong op2 to cfFloating"

cfFloatingB :: I.ExpOp
            -> [CfVal]
            -> CfVal
cfFloatingB op [x] = case x of
  CfFloat f  -> CfBool  (op' f)
  CfDouble d -> CfBool  (op' d)
  _          -> CfExpr  (I.ExpOp op [toExpr x])
  where
  op' :: RealFloat a => a -> Bool
  op' = case op of
    I.ExpIsNan _ -> isNaN
    I.ExpIsInf _ -> isInfinite
    _            -> err "wrong op to cfFloatingB"
cfFloatingB _ _ = err "wrong number of args to cfFloatingB"

--------------------------------------------------------------------------------

err :: String -> a
err msg = error $ "Ivory-Opts internal error: " ++ msg

