# S04: FEATURE SPECS - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Creation Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| default_create | `()` | Create 0/1 |
| make | `(num, den: INTEGER_64)` | Create num/den |
| make_integer | `(value: INTEGER_64)` | Create value/1 |
| make_mixed | `(whole, num, den: INTEGER_64)` | Create whole num/den |
| make_from_string | `(str: STRING)` | Parse string |
| make_zero | `()` | Create 0/1 |
| make_one | `()` | Create 1/1 |

## Access Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| numerator | `: INTEGER_64` | Top number |
| denominator | `: INTEGER_64` | Bottom number (> 0) |

## Status Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| is_zero | `: BOOLEAN` | numerator = 0 |
| is_negative | `: BOOLEAN` | numerator < 0 |
| is_positive | `: BOOLEAN` | numerator > 0 |
| is_integer | `: BOOLEAN` | denominator = 1 |
| is_proper | `: BOOLEAN` | abs(num) < den |
| is_improper | `: BOOLEAN` | abs(num) >= den |
| is_reduced | `: BOOLEAN` | GCD = 1 |
| is_unit_fraction | `: BOOLEAN` | numerator = 1 |

## Comparison Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| is_less alias "<" | `(other): BOOLEAN` | Cross-multiply compare |
| is_equal | `(other): BOOLEAN` | num/den equal |

## Conversion Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| to_double | `: DOUBLE` | num / den |
| to_integer | `: INTEGER_64` | num // den |
| whole_part | `: INTEGER_64` | num // den |
| fractional_part | `: SIMPLE_FRACTION` | Remainder |
| out | `: STRING` | "num/den" or "int" |
| to_string | `: STRING` | Same as out |
| to_mixed_string | `: STRING` | "whole num/den" |
| to_decimal_string | `(places: INTEGER): STRING` | Decimal format |

## Arithmetic Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| add alias "+" | `(other): SIMPLE_FRACTION` | Sum |
| subtract alias "-" | `(other): SIMPLE_FRACTION` | Difference |
| multiply alias "*" | `(other): SIMPLE_FRACTION` | Product |
| divide alias "/" | `(other): SIMPLE_FRACTION` | Quotient |
| negate | `: SIMPLE_FRACTION` | -self |
| absolute | `: SIMPLE_FRACTION` | abs(self) |
| reciprocal | `: SIMPLE_FRACTION` | 1/self |
| power | `(n: INTEGER): SIMPLE_FRACTION` | self^n |

## Scaling Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| scale | `(factor: INTEGER_64): SIMPLE_FRACTION` | Multiply by int |
| scale_down | `(factor: INTEGER_64): SIMPLE_FRACTION` | Divide by int |

## Factory Features

| Feature | Signature | Description |
|---------|-----------|-------------|
| zero | `: SIMPLE_FRACTION` | 0/1 |
| one | `: SIMPLE_FRACTION` | 1/1 |
| half | `: SIMPLE_FRACTION` | 1/2 |
| third | `: SIMPLE_FRACTION` | 1/3 |
| quarter | `: SIMPLE_FRACTION` | 1/4 |
| halves | `(n: INTEGER_64): SIMPLE_FRACTION` | n/2 |
| thirds | `(n: INTEGER_64): SIMPLE_FRACTION` | n/3 |
| quarters | `(n: INTEGER_64): SIMPLE_FRACTION` | n/4 |
| eighths | `(n: INTEGER_64): SIMPLE_FRACTION` | n/8 |
| sixteenths | `(n: INTEGER_64): SIMPLE_FRACTION` | n/16 |
