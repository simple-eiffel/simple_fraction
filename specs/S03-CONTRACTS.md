# S03: CONTRACTS - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## SIMPLE_FRACTION Contracts

### Invariants
```eiffel
invariant
    denominator_positive: denominator > 0
    reduced_form: is_reduced
```

### Creation Contracts

#### make
```eiffel
require
    denominator_not_zero: a_denominator /= 0
ensure
    is_reduced: is_reduced
    denominator_positive: denominator > 0
```

#### make_mixed
```eiffel
require
    denominator_not_zero: a_denominator /= 0
    numerator_non_negative: a_numerator >= 0
    denominator_positive: a_denominator > 0
ensure
    is_reduced: is_reduced
    denominator_positive: denominator > 0
```

#### make_from_string
```eiffel
require
    not_empty: a_str /= Void and then not a_str.is_empty
ensure
    is_reduced: is_reduced
    denominator_positive: denominator > 0
```

### Status Contracts

#### is_zero
```eiffel
ensure
    definition: Result = (numerator = 0)
```

#### is_negative
```eiffel
ensure
    definition: Result = (numerator < 0)
```

#### is_integer
```eiffel
ensure
    definition: Result = (denominator = 1)
```

#### is_proper
```eiffel
ensure
    definition: Result = (numerator.abs < denominator)
```

### Arithmetic Contracts

#### add, subtract, multiply
```eiffel
require
    other_not_void: other /= Void
ensure
    result_not_void: Result /= Void
    result_reduced: Result.is_reduced
```

#### divide
```eiffel
require
    other_not_void: other /= Void
    other_not_zero: not other.is_zero
ensure
    result_not_void: Result /= Void
    result_reduced: Result.is_reduced
```

#### reciprocal
```eiffel
require
    not_zero: not is_zero
ensure
    result_not_void: Result /= Void
    reciprocal_property: (Current * Result).is_equal (one)
```

### Conversion Contracts

#### fractional_part
```eiffel
ensure
    result_proper: Result.is_proper or Result.is_zero
    result_non_negative: not Result.is_negative
```
