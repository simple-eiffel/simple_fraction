# S02: CLASS CATALOG - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Class Hierarchy

```
ANY
    +-- SIMPLE_FRACTION
            |
            +-- inherits COMPARABLE
```

## Class Details

### SIMPLE_FRACTION

**Purpose:** Exact rational number arithmetic
**Responsibility:** Represent and manipulate fractions

| Feature Category | Count |
|-----------------|-------|
| Creation | 7 |
| Access | 2 |
| Status | 8 |
| Comparison | 2 |
| Conversion | 7 |
| Arithmetic | 8 |
| Scaling | 2 |
| Factories | 10 |
| Internal | 2 |

**Creation:**
- default_create (0/1)
- make (numerator, denominator)
- make_integer (value)
- make_mixed (whole, num, den)
- make_from_string (string)
- make_zero
- make_one

**Access:**
- numerator: INTEGER_64
- denominator: INTEGER_64

**Status Queries:**
- is_zero, is_negative, is_positive
- is_integer, is_proper, is_improper
- is_reduced, is_unit_fraction

**Arithmetic:**
- add alias "+"
- subtract alias "-"
- multiply alias "*"
- divide alias "/"
- negate, absolute, reciprocal, power

**Conversion:**
- to_double, to_integer
- whole_part, fractional_part
- out, to_string, to_mixed_string
- to_decimal_string

**Factories:**
- zero, one, half, third, quarter
- halves, thirds, quarters, eighths, sixteenths
