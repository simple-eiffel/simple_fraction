# 7S-05: SECURITY - simple_fraction


**Date**: 2026-01-23

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Security Considerations

### Threat Model

| Threat | Mitigation | Status |
|--------|------------|--------|
| Integer overflow | INTEGER_64 range | Partial |
| Division by zero | Preconditions | Implemented |
| Denial of service | No mitigation | N/A |
| String parsing | Defensive parsing | Implemented |

### Integer Overflow

#### Arithmetic Overflow Risk
Multiplication can overflow:
```eiffel
-- a/b * c/d = (a*c) / (b*d)
-- If a, c are large, a*c may overflow INTEGER_64
```

Maximum safe values:
- INTEGER_64 max: 9,223,372,036,854,775,807
- Safe multiplication: values < 3,037,000,499

#### Current Mitigation
- No runtime overflow detection
- GCD reduction helps by keeping values smaller
- Application responsibility for large values

### Division by Zero

#### Protected Operations
```eiffel
make (a_numerator: INTEGER_64; a_denominator: INTEGER_64)
    require
        denominator_not_zero: a_denominator /= 0

divide alias "/" (other: like Current): SIMPLE_FRACTION
    require
        other_not_zero: not other.is_zero
```

### String Parsing Security

#### Defensive Parsing
- Empty parts default to 0/1
- Invalid format defaults to 0/1
- Division by zero in string caught

### Known Limitations

1. **No overflow detection:** Large value operations may overflow
2. **No precision limit:** Deep recursion possible with repeated operations
3. **String parsing permissive:** Invalid input becomes 0/1

### Security Recommendations

1. Validate input ranges for critical applications
2. Use for small/medium values, not cryptographic
3. Check for overflow in financial applications
4. Validate string input before parsing
