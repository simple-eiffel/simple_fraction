# 7S-01: SCOPE - simple_fraction


**Date**: 2026-01-23

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Problem Domain

Exact rational arithmetic using fractions. The library provides precise representation of rational numbers as numerator/denominator pairs, avoiding floating-point precision issues.

## Target Users

- Eiffel developers needing exact arithmetic
- Financial applications requiring precise calculations
- Recipe/measurement applications
- Music applications (time signatures, note durations)
- Educational software teaching fractions

## Problem Statement

Floating-point arithmetic has precision limitations. For example:
- 1/3 + 1/3 + 1/3 != 1 in floating point
- 0.1 + 0.2 != 0.3 in floating point

Developers need exact rational arithmetic where 1/3 + 1/3 + 1/3 = 1 exactly.

## Boundaries

### In Scope
- Fraction representation (numerator/denominator)
- Automatic reduction to lowest terms (GCD)
- Mixed number support (2 3/4)
- Full arithmetic (+, -, *, /)
- Comparison operators (<, <=, =, >=, >)
- Conversion to/from decimals and strings
- Common fraction factories (half, third, quarter)
- Power operations
- Proper/improper fraction queries

### Out of Scope
- Arbitrary precision integers
- Continued fractions
- Complex fractions
- Interval arithmetic
- Symbolic algebra

## Success Criteria

1. Exact rational arithmetic (1/3 + 1/3 + 1/3 = 1)
2. Automatic GCD reduction
3. Clean string parsing/output
4. Full COMPARABLE integration
5. Immutable operations

## Dependencies

- EiffelBase (STRING, FORMAT_DOUBLE)
- COMPARABLE inheritance
