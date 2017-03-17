-- | This module defines a `Decimal` data type for arbitrary precision numbers.
module Data.Decimal
  ( Decimal(..)
  , fromString
  , fromInt
  , fromNumber
  , toString
  , toNumber
  , abs
  , pow
  , acos
  , acosh
  , asin
  , asinh
  , atan
  , atanh
  , atan2
  , ceil
  , cos
  , cosh
  , exp
  , floor
  , ln
  , log10
  , max
  , min
  , round
  , sin
  , sinh
  , sqrt
  , tan
  , tanh
  , e
  , pi
  ) where

import Prelude

import Data.Maybe (Maybe(..))

-- | An arbitrary precision number.
foreign import data Decimal ∷ *

-- | Convert an integer to a Decimal.
foreign import fromInt ∷ Int → Decimal

-- | Convert a number to a Decimal.
foreign import fromNumber ∷ Number → Decimal

-- | Converts a Decimal to a Number, possibly resulting in loss of precision.
foreign import toNumber ∷ Decimal → Number

foreign import fromString' ∷ ∀ a. Maybe a → (a → Maybe a) → String → Maybe Decimal

-- | Parse a string into a `Decimal`, assuming a decimal representation. Returns
-- | `Nothing` if the parse fails.
-- |
-- | Examples:
-- | ```purescript
-- | fromString "42.001"
-- | fromString "857981209301293808359384092830482"
-- | fromString "1e100"
-- | fromString "0.12301928309128183579487598149533"
-- | ```
fromString ∷ String → Maybe Decimal
fromString = fromString' Nothing Just

foreign import dEquals ∷ Decimal → Decimal → Boolean

instance eqDecimal ∷ Eq Decimal where
  eq = dEquals

foreign import dCompare ∷ Decimal → Decimal → Int

instance ordDecimal ∷ Ord Decimal where
  compare x y =
    case dCompare x y of
      1 → GT
      0 → EQ
      _ → LT

-- | A decimal representation of the `Decimal` as a `String`.
foreign import toString ∷ Decimal → String

instance showDecimal ∷ Show Decimal where
  show x = "(fromString \"" <> toString x <> "\")"

foreign import dAdd ∷ Decimal → Decimal → Decimal
foreign import dMul ∷ Decimal → Decimal → Decimal

instance semiringDecimal ∷ Semiring Decimal where
  add  = dAdd
  zero = fromInt 0
  mul  = dMul
  one  = fromInt 1

foreign import dSub ∷ Decimal → Decimal → Decimal

instance ringDecimal ∷ Ring Decimal where
  sub = dSub

foreign import dDiv ∷ Decimal → Decimal → Decimal

instance commutativeRingDecimal ∷ CommutativeRing Decimal

instance euclideanRingDecimal ∷ EuclideanRing Decimal where
  div = dDiv
  mod _ _ = zero
  degree _ = one

-- | Exponentiation for `Decimal`.
foreign import pow ∷ Decimal → Decimal → Decimal

-- | The absolute value.
foreign import abs ∷ Decimal → Decimal

-- | Inverse cosine.
foreign import acos ∷ Decimal → Decimal

-- | Inverse hyperbolic cosine.
foreign import acosh ∷ Decimal → Decimal

-- | Hyperbolic sine.
foreign import asin ∷ Decimal → Decimal

-- | Inverse hyperbolic sine.
foreign import asinh ∷ Decimal → Decimal

-- | Inverse tangent.
foreign import atan ∷ Decimal → Decimal

-- | Inverse hyperbolic tangent.
foreign import atanh ∷ Decimal → Decimal

-- | Inverse hyperbolic tangent.
foreign import atan2 ∷ Decimal → Decimal → Decimal

-- | Rounded to next whole number in the direction of `+inf`.
foreign import ceil ∷ Decimal → Decimal

-- | Cosine.
foreign import cos ∷ Decimal → Decimal

-- | Hyperbolic cosine.
foreign import cosh ∷ Decimal → Decimal

-- | Exponential function.
foreign import exp ∷ Decimal → Decimal

-- | Rounded to next whole number in the direction of `-inf`.
foreign import floor ∷ Decimal → Decimal

-- | Natural logarithm.
foreign import ln ∷ Decimal → Decimal

-- | Logarithm with base `2`.
foreign import log2 ∷ Decimal → Decimal

-- | Logarithm with base `10`.
foreign import log10 ∷ Decimal → Decimal

-- | The larger of two numbers.
foreign import max ∷ Decimal → Decimal → Decimal

-- | The smaller of two numbers.
foreign import min ∷ Decimal → Decimal → Decimal

-- | Round to the nearest whole number.
foreign import round ∷ Decimal → Decimal

-- | Sine.
foreign import sin ∷ Decimal → Decimal

-- | Hyperbolic sine.
foreign import sinh ∷ Decimal → Decimal

-- | Square root.
foreign import sqrt ∷ Decimal → Decimal

-- | Tangent.
foreign import tan ∷ Decimal → Decimal

-- | Hyperbolic tangent.
foreign import tanh ∷ Decimal → Decimal

-- | Euler's number.
e ∷ Decimal
e = exp one

-- | Pi, the ratio of a circle's circumference to its diameter.
pi ∷ Decimal
pi = acos (-one)
