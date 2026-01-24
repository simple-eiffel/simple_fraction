# 7S-02: STANDARDS - simple_fraction


**Date**: 2026-01-23

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Applicable Standards

### Mathematical Standards

#### Rational Number Representation
- Fraction: a/b where b != 0
- Canonical form: GCD(a,b) = 1, b > 0
- Zero: 0/1

#### Arithmetic Operations
- Addition: a/b + c/d = (ad + cb) / bd
- Subtraction: a/b - c/d = (ad - cb) / bd
- Multiplication: a/b * c/d = ac / bd
- Division: a/b / c/d = ad / bc (c != 0)

#### GCD Algorithm
- Euclidean algorithm for greatest common divisor
- Used for reduction to lowest terms

### Eiffel Standards

#### COMPARABLE
- Inherit from COMPARABLE
- Implement is_less (alias "<")
- Get <=, >, >=, max, min automatically

#### Immutable Pattern
- Operations return new objects
- Original fraction unchanged
- Thread-safe by design

## Implementation Status

| Standard | Coverage | Notes |
|---------|----------|-------|
| Canonical form | Complete | Auto-reduce |
| Arithmetic ops | Complete | All four |
| Comparison | Complete | Via COMPARABLE |
| GCD reduction | Complete | Euclidean |
| Mixed numbers | Complete | Parse and format |
| String parsing | Complete | Multiple formats |

## Compliance Notes

- Denominator always positive (sign in numerator)
- Zero stored as 0/1
- INTEGER_64 for wide range
- Euclidean GCD for efficiency
