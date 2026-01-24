# S01: PROJECT INVENTORY - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Project Structure

```
simple_fraction/
    +-- src/
    |   +-- simple_fraction.e    # Main fraction class
    |
    +-- testing/
    |   +-- test_app.e
    |   +-- lib_tests.e
    |   +-- simple_fraction_tests.e
    |
    +-- research/
    +-- specs/
    +-- simple_fraction.ecf
    +-- README.md
```

## File Inventory

| File | Lines | Purpose |
|------|-------|---------|
| simple_fraction.e | 680 | Fraction arithmetic |

## Dependencies

### Internal
- None

### External
- EiffelBase (STRING, FORMAT_DOUBLE, LIST)
- COMPARABLE

## Build Targets

| Target | Purpose |
|--------|---------|
| simple_fraction | Library |
| simple_fraction_tests | Test suite |
