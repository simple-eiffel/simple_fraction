# 7S-06: SIZING - simple_fraction

**Status:** BACKWASH (reverse-engineered from implementation)
**Date:** 2026-01-23
**Library:** simple_fraction

## Implementation Size

### Actual Implementation

| Component | Lines | Complexity |
|-----------|-------|------------|
| SIMPLE_FRACTION | ~680 | Medium |
| **Total Source** | **~680** | **Medium** |

### Test Coverage

| Test File | Lines | Tests |
|-----------|-------|-------|
| simple_fraction_tests.e | ~200 | Core tests |
| lib_tests.e | ~50 | Integration |
| test_app.e | ~30 | Runner |
| **Total Tests** | **~280** | |

### Complexity Breakdown

#### Simple (accessors)
- numerator, denominator: Direct access
- is_zero, is_negative, is_positive: Simple checks
- Factory methods: Delegation to make

#### Medium (algorithms)
- Arithmetic: Cross-multiplication
- GCD computation: Euclidean algorithm
- String parsing: Multiple formats
- Mixed number conversion: Division/modulo

### Feature Count

| Category | Count |
|----------|-------|
| Creation | 7 |
| Access | 2 |
| Status | 8 |
| Comparison | 2 |
| Conversion | 7 |
| Arithmetic | 8 |
| Scaling | 2 |
| Factories | 10 |
| Internal | 2 |

### Dependencies

```
simple_fraction
    +-- EiffelBase
    |   +-- STRING
    |   +-- LIST
    |   +-- FORMAT_DOUBLE
    +-- COMPARABLE
```

### Build Time Impact
- Clean build: ~5 seconds
- Incremental: ~2 seconds
- No C compilation

### Runtime Footprint
- Memory: 16 bytes per fraction (two INTEGER_64)
- CPU: GCD on every operation
- No caching
