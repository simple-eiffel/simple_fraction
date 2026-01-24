# S05: CONSTRAINTS - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Technical Constraints

### Numeric Constraints

| Constraint | Value | Rationale |
|------------|-------|-----------|
| Integer type | INTEGER_64 | Wide range |
| Max numerator | 2^63 - 1 | INTEGER_64 max |
| Max denominator | 2^63 - 1 | INTEGER_64 max |
| Overflow | Not detected | Performance |

### Representation Constraints

| Constraint | Rule | Rationale |
|------------|------|-----------|
| Denominator | Always > 0 | Canonical form |
| Reduction | Always GCD=1 | Canonical form |
| Sign | In numerator | Canonical form |
| Zero | 0/1 | Canonical form |

## Business Rules

### Arithmetic Rules

1. **Reduction:** All results auto-reduced
2. **Immutability:** Operations return new objects
3. **Division:** Cannot divide by zero

### Comparison Rules

1. **Cross-multiply:** a/b < c/d iff a*d < c*b
2. **Equality:** Compare num and den (both reduced)

### String Parsing Rules

Accepted formats:
- "3/4" - Simple fraction
- "5" - Integer
- "2 3/4" - Mixed number
- "0.75" - Decimal

Invalid input becomes 0/1.

## State Constraints

### Invariants Always True
- denominator > 0
- GCD(abs(numerator), denominator) = 1 (or numerator = 0)

### Creation Postconditions
- All creation procedures establish invariants
- Invalid input (except /0) defaults to 0/1

## Error Conditions

| Condition | Behavior |
|-----------|----------|
| Denominator = 0 in make | Contract violation |
| Division by zero | Contract violation |
| Reciprocal of zero | Contract violation |
| Invalid string | Default to 0/1 |
| Overflow | Undefined behavior |
