# 7S-04: SIMPLE-STAR - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Ecosystem Integration

### Used By

| Library | Potential Use |
|---------|---------------|
| simple_units | Unit conversions |
| simple_recipe | Ingredient amounts |
| simple_music | Time signatures |
| Application | Exact calculations |

### Dependencies

| Library | Purpose |
|---------|---------|
| EiffelBase | STRING, FORMAT_DOUBLE |
| COMPARABLE | Ordering |

## API Consistency

### Naming Conventions
- Class: SIMPLE_FRACTION
- Queries: is_*, has_* for booleans
- Factories: zero, one, half, third, quarter
- Arithmetic: Eiffel operators (+, -, *, /)

### Creation Patterns
```eiffel
-- Basic
create f.make (3, 4)           -- 3/4
create f.make_integer (5)      -- 5/1
create f.make_mixed (2, 3, 4)  -- 2 3/4 = 11/4

-- From string
create f.make_from_string ("3/4")
create f.make_from_string ("2 3/4")
create f.make_from_string ("0.75")

-- Factories
f := f.half    -- 1/2
f := f.third   -- 1/3
f := f.quarter -- 1/4
```

## Ecosystem Patterns Applied

### Immutable Pattern
All arithmetic returns new fractions:
```eiffel
a := b + c  -- b and c unchanged
```

### COMPARABLE Integration
```eiffel
inherit
    COMPARABLE
        undefine default_create, out, is_equal end
```

### Design by Contract
- Preconditions: denominator != 0
- Postconditions: result is reduced
- Invariants: denominator > 0, is_reduced

### Alias Pattern
```eiffel
add alias "+" (other: like Current): SIMPLE_FRACTION
subtract alias "-" (other: like Current): SIMPLE_FRACTION
multiply alias "*" (other: like Current): SIMPLE_FRACTION
divide alias "/" (other: like Current): SIMPLE_FRACTION
```
