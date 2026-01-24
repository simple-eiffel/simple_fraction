# S06: BOUNDARIES - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Class Boundaries

### Inheritance

```
ANY
    |
    +-- redefine: default_create, out, is_equal
    v
SIMPLE_FRACTION
    |
    +-- undefine: default_create, out, is_equal
    v
COMPARABLE
```

### Feature Groups

```
+----------------------------------------------------------+
|                    SIMPLE_FRACTION                        |
|                                                          |
| +---------------+  +--------------+  +---------------+   |
| | Creation      |  | Access       |  | Status        |   |
| | make, make_*  |  | numerator    |  | is_zero, etc. |   |
| +---------------+  | denominator  |  +---------------+   |
|                    +--------------+                      |
| +---------------+  +--------------+  +---------------+   |
| | Comparison    |  | Conversion   |  | Arithmetic    |   |
| | <, is_equal   |  | to_*, out    |  | +, -, *, /    |   |
| +---------------+  +--------------+  +---------------+   |
|                                                          |
| +---------------+  +---------------+                     |
| | Scaling       |  | Factories    |                     |
| | scale, down   |  | zero, one... |                     |
| +---------------+  +---------------+                     |
|                                                          |
| +---------------+                                        |
| | Internal      |                                        |
| | set_and_reduce|                                        |
| | gcd           |                                        |
| +---------------+                                        |
+----------------------------------------------------------+
```

## Interface Boundaries

### Public API

```eiffel
-- Creation
make (num, den)
make_integer (value)
make_mixed (whole, num, den)
make_from_string (str)

-- Access
numerator: INTEGER_64
denominator: INTEGER_64

-- Arithmetic
+ - * / (other): SIMPLE_FRACTION
negate, absolute, reciprocal: SIMPLE_FRACTION
power (n): SIMPLE_FRACTION

-- Comparison (from COMPARABLE)
<, <=, >, >=, is_equal

-- Conversion
to_double, to_integer
out, to_mixed_string
```

### Internal API

```eiffel
-- Private helpers
set_and_reduce (num, den)
gcd (a, b): INTEGER_64
```

## Data Flow

### Creation Flow
```
Input (num, den)
    |
    | set_and_reduce
    v
Normalize sign (den > 0)
    |
    | gcd (abs(num), den)
    v
Reduce to lowest terms
    |
    v
Canonical fraction
```

### Arithmetic Flow
```
Fraction A + Fraction B
    |
    | (a.num * b.den + b.num * a.den, a.den * b.den)
    v
Create new fraction
    |
    | Auto-reduce via set_and_reduce
    v
Result (canonical form)
```
