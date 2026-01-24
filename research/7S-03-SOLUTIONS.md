# 7S-03: SOLUTIONS - simple_fraction


**Date**: 2026-01-23

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Existing Solutions Comparison

### Python fractions.Fraction
- **Pros:** Built-in, arbitrary precision
- **Cons:** Python-specific
- **Approach:** Immutable, auto-reduce

### Java BigRational (various)
- **Pros:** Arbitrary precision
- **Cons:** Not in stdlib, verbose
- **Approach:** BigInteger based

### C++ Boost.Rational
- **Pros:** Template-based, efficient
- **Cons:** Boost dependency
- **Approach:** Templates with any integer type

### Ruby Rational
- **Pros:** Built-in, clean syntax
- **Cons:** Ruby-specific
- **Approach:** Literal syntax (1/3r)

## simple_fraction Approach

### Design Philosophy
- Pure Eiffel implementation
- INTEGER_64 for range without complexity
- Immutable operations
- DBC for correctness
- Multiple creation options

### Key Differentiators

1. **Eiffel-Native:** Pure Eiffel, no dependencies
2. **DBC Integration:** Contracts verify arithmetic
3. **Mixed Number Support:** Parse and format
4. **Factory Methods:** half, third, quarter, etc.
5. **COMPARABLE:** Full ordering support

### Architecture

```
SIMPLE_FRACTION
    |
    +-- inherits ANY (with redefinitions)
    +-- inherits COMPARABLE
    |
    +-- numerator: INTEGER_64
    +-- denominator: INTEGER_64
    |
    +-- Arithmetic: +, -, *, /
    +-- Comparison: <, <=, =, >=, >
    +-- Conversion: out, to_double, to_mixed_string
```

### Trade-offs Made

| Decision | Benefit | Cost |
|----------|---------|------|
| INTEGER_64 | Wide range | Not arbitrary precision |
| Immutable | Thread-safe | Memory allocation |
| Auto-reduce | Canonical | CPU on every operation |
| GCD | Efficiency | Overflow risk on large values |
