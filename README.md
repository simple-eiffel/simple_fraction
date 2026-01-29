<p align="center">
  <img src="https://raw.githubusercontent.com/simple-eiffel/.github/main/profile/assets/logo.svg" alt="simple_ library logo" width="400">
</p>

# simple_fraction

**[Documentation](https://simple-eiffel.github.io/simple_fraction/)** | **[GitHub](https://github.com/simple-eiffel/simple_fraction)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Eiffel](https://img.shields.io/badge/Eiffel-25.02-blue.svg)](https://www.eiffel.org/)
[![Design by Contract](https://img.shields.io/badge/DbC-enforced-orange.svg)]()

Exact rational arithmetic with fractions and mixed numbers for Eiffel. Perfect for recipes, measurements, probabilities, and any calculation where 1/3 + 1/3 + 1/3 must equal exactly 1.

Part of the [Simple Eiffel](https://github.com/simple-eiffel) ecosystem.

**Developed using AI-assisted methodology:** Built interactively with Claude Opus 4.5 following rigorous Design by Contract principles.

## The Problem

Decimal and floating-point cannot represent many fractions exactly:

```eiffel
-- DOUBLE fails for repeating decimals!
io.put_double (1.0/3.0 + 1.0/3.0 + 1.0/3.0)  -- May not equal exactly 1.0
```

This causes real-world problems:
- Recipe scaling that doesn't work out
- Measurement calculations that accumulate error
- Probability calculations that don't sum to 1
- Ratios that lose precision

## The Solution

SIMPLE_FRACTION uses exact rational arithmetic:

```eiffel
local
    third, total: SIMPLE_FRACTION
do
    create third.make (1, 3)
    total := third + third + third
    print (total.out)  -- Outputs: "1" (exactly 3/3 = 1)
end
```

## Quick Start

```eiffel
class
    RECIPE_SCALER

feature -- Scaling

    scale_ingredient (amount: STRING; scale_factor: INTEGER): STRING
            -- Scale a fractional ingredient amount
        local
            fraction, scaled: SIMPLE_FRACTION
        do
            create fraction.make_from_string (amount)
            scaled := fraction.scale (scale_factor)
            Result := scaled.to_mixed_string
        end

end
```

**Usage:**
```eiffel
scaler.scale_ingredient ("2/3", 3)   -- Returns: "2"
scaler.scale_ingredient ("1/4", 2)   -- Returns: "1/2"
scaler.scale_ingredient ("3/4", 4)   -- Returns: "3"
```

## Features

### Creation Methods

```eiffel
-- From numerator/denominator
create half.make (1, 2)        -- 1/2
create third.make (1, 3)       -- 1/3

-- From mixed number: 2 3/4 = 11/4
create mixed.make_mixed (2, 3, 4)

-- From string (multiple formats)
create f.make_from_string ("3/4")      -- Simple fraction
create f.make_from_string ("2 3/4")    -- Mixed number
create f.make_from_string ("0.5")      -- Decimal -> 1/2
create f.make_from_string ("5")        -- Integer

-- From integer
create five.make_integer (5)

-- Special values
create zero.make_zero
create one.make_one
```

### Arithmetic Operations

All operations are immutable (return new SIMPLE_FRACTION):

```eiffel
result := a + b        -- Addition
result := a - b        -- Subtraction
result := a * b        -- Multiplication
result := a / b        -- Division
result := a.negate     -- Negation
result := a.absolute   -- Absolute value
result := a.reciprocal -- Flip fraction (1/a)
result := a.power (n)  -- Exponentiation
result := a.scale (n)  -- Multiply by integer
```

### Automatic Reduction

Fractions are always reduced to lowest terms:

```eiffel
create f.make (2, 4)   -- Automatically becomes 1/2
create f.make (6, 9)   -- Automatically becomes 2/3
create f.make (100, 25) -- Automatically becomes 4
```

### Comparison

```eiffel
if a < b then ...
if a <= b then ...
if a > b then ...
if a >= b then ...
if a.is_equal (b) then ...
```

### Mixed Number Support

```eiffel
-- Create mixed number
create f.make_mixed (2, 3, 4)  -- 2 3/4 = 11/4

-- Convert to mixed string
f.to_mixed_string  -- "2 3/4"

-- Extract parts
f.whole_part        -- 2
f.fractional_part   -- 3/4 (as SIMPLE_FRACTION)
```

### Status Queries

```eiffel
f.is_zero          -- Is 0?
f.is_negative      -- Is < 0?
f.is_positive      -- Is > 0?
f.is_integer       -- Is whole number?
f.is_proper        -- Is |numerator| < denominator?
f.is_improper      -- Is |numerator| >= denominator?
f.is_unit_fraction -- Is numerator = 1?
f.is_reduced       -- Is in lowest terms? (always true)
```

### Common Fractions Factory

```eiffel
f.half      -- 1/2
f.third     -- 1/3
f.quarter   -- 1/4

f.halves (3)     -- 3/2
f.thirds (2)     -- 2/3
f.quarters (3)   -- 3/4
f.eighths (5)    -- 5/8
f.sixteenths (7) -- 7/16
```

### Output Formatting

```eiffel
f.out              -- "3/4" or "5" (integers without denominator)
f.to_string        -- Same as out
f.to_mixed_string  -- "2 3/4" for improper fractions
f.to_decimal_string (2)  -- "0.75"
```

## Installation

### Environment Setup

Set the ecosystem environment variable (one-time setup for all simple_* libraries):

```bash
export SIMPLE_EIFFEL=D:\prod
```

### ECF Configuration

Add to your project's `.ecf` file:

```xml
<library name="simple_fraction" location="$SIMPLE_EIFFEL/simple_fraction/simple_fraction.ecf"/>
```

### Dependencies

- EiffelStudio 25.02+
- No external dependencies (pure Eiffel implementation)

## Building from Source

```bash
cd /path/to/simple_fraction
ec.exe -batch -config simple_fraction.ecf -target simple_fraction_tests -c_compile

# Run tests
./EIFGENs/simple_fraction_tests/W_code/simple_fraction.exe
```

## simple_fraction vs simple_decimal

| Feature | simple_fraction | simple_decimal |
|---------|-----------------|----------------|
| Best for | Ratios, recipes, probabilities | Money, financial, prices |
| 1/3 | Exact | Approximate |
| 0.1 | 1/10 (exact) | Exact |
| Output | "2 3/4" | "$19.99" |
| Underlying | INTEGER_64 numerator/denominator | Gobo MA_DECIMAL |

**Use simple_fraction when:**
- Working with recipes and measurements
- Calculating probabilities
- Dealing with ratios and proportions
- Need exact representation of repeating decimals

**Use simple_decimal when:**
- Working with money and currency
- Need specific decimal precision
- Displaying prices and financial data

## License

MIT License - See [LICENSE](LICENSE) file.

## Resources

- [Simple Eiffel Organization](https://github.com/simple-eiffel)
- [Rational Arithmetic (Wikipedia)](https://en.wikipedia.org/wiki/Rational_number)
