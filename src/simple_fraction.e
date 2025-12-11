note
	description: "[
		SIMPLE_FRACTION - Exact rational arithmetic with fractions and mixed numbers.

		Part of the simple_* library ecosystem. Provides exact representation
		of rational numbers as fractions (numerator/denominator), with automatic
		reduction to lowest terms.

		Key Features:
		- Exact rational arithmetic (1/3 + 1/3 + 1/3 = 1 exactly)
		- Automatic reduction to lowest terms via GCD
		- Mixed number support (2 3/4 = 11/4)
		- Proper fraction handling
		- Full arithmetic: +, -, *, /
		- Comparison operators
		- Conversion to/from decimals and strings
		- Immutable operations

		Quick Start:
			half: SIMPLE_FRACTION
			third: SIMPLE_FRACTION
			result: SIMPLE_FRACTION

			create half.make (1, 2)      -- 1/2
			create third.make (1, 3)     -- 1/3
			result := half + third       -- 5/6
			print (result.out)           -- "5/6"

		Why SIMPLE_FRACTION over decimals?
			-- Decimal cannot represent 1/3 exactly:
			print ((1.0 / 3.0).out)  -- "0.33333333..." (truncated)

			-- SIMPLE_FRACTION is exact:
			create third.make (1, 3)
			result := third + third + third
			print (result.out)  -- "1" (exactly 3/3 = 1)

		Mixed Numbers:
			create mixed.make_mixed (2, 3, 4)  -- 2 3/4
			print (mixed.out)                   -- "11/4"
			print (mixed.to_mixed_string)       -- "2 3/4"

		Common Use Cases:
		- Recipes (1/2 cup, 3/4 teaspoon)
		- Measurements (2 1/4 inches)
		- Probabilities (1/6 chance)
		- Ratios and proportions
		- Music (time signatures, note durations)
		- Any calculation requiring exact rational results
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_FRACTION

inherit
	ANY
		redefine
			default_create,
			out,
			is_equal
		end

	COMPARABLE
		undefine
			default_create,
			out,
			is_equal
		end

create
	default_create,
	make,
	make_integer,
	make_mixed,
	make_from_string,
	make_zero,
	make_one

feature {NONE} -- Initialization

	default_create
			-- Create zero fraction (0/1)
		do
			numerator := 0
			denominator := 1
		ensure then
			is_zero: is_zero
			normalized: denominator = 1
		end

	make (a_numerator: INTEGER_64; a_denominator: INTEGER_64)
			-- Create fraction from numerator and denominator.
			-- Automatically reduces to lowest terms.
		require
			denominator_not_zero: a_denominator /= 0
		do
			set_and_reduce (a_numerator, a_denominator)
		ensure
			is_reduced: is_reduced
			denominator_positive: denominator > 0
		end

	make_integer (a_value: INTEGER_64)
			-- Create fraction from integer (value/1)
		do
			numerator := a_value
			denominator := 1
		ensure
			correct_value: numerator = a_value
			denominator_is_one: denominator = 1
		end

	make_mixed (a_whole: INTEGER_64; a_numerator: INTEGER_64; a_denominator: INTEGER_64)
			-- Create from mixed number: whole + numerator/denominator.
			-- Example: make_mixed (2, 3, 4) creates 2 3/4 = 11/4
		require
			denominator_not_zero: a_denominator /= 0
			numerator_non_negative: a_numerator >= 0
			denominator_positive: a_denominator > 0
		local
			l_num: INTEGER_64
		do
			if a_whole >= 0 then
				l_num := a_whole * a_denominator + a_numerator
			else
				l_num := a_whole * a_denominator - a_numerator
			end
			set_and_reduce (l_num, a_denominator)
		ensure
			is_reduced: is_reduced
			denominator_positive: denominator > 0
		end

	make_from_string (a_str: READABLE_STRING_GENERAL)
			-- Create from string representation.
			-- Accepts: "3/4", "-1/2", "5", "2 3/4" (mixed), "0.5"
		require
			not_empty: a_str /= Void and then not a_str.is_empty
		local
			l_str: STRING
			l_parts: LIST [STRING]
			l_num, l_den: INTEGER_64
			l_whole: INTEGER_64
			l_decimal_pos: INTEGER
			l_decimal_places: INTEGER
			i: INTEGER
		do
			l_str := a_str.to_string_8.twin
			l_str.left_adjust
			l_str.right_adjust

			if l_str.has ('/') then
				-- Fraction format: "3/4" or "2 3/4"
				if l_str.has (' ') then
					-- Mixed number: "2 3/4"
					l_parts := l_str.split (' ')
					if l_parts.count >= 2 then
						l_whole := l_parts[1].to_integer_64
						l_parts := l_parts[2].split ('/')
						if l_parts.count >= 2 then
							l_num := l_parts[1].to_integer_64
							l_den := l_parts[2].to_integer_64
							if l_den /= 0 then
								if l_whole >= 0 then
									l_num := l_whole * l_den + l_num
								else
									l_num := l_whole * l_den - l_num
								end
								set_and_reduce (l_num, l_den)
							else
								set_and_reduce (0, 1)
							end
						else
							set_and_reduce (0, 1)
						end
					else
						set_and_reduce (0, 1)
					end
				else
					-- Simple fraction: "3/4"
					l_parts := l_str.split ('/')
					if l_parts.count >= 2 then
						l_num := l_parts[1].to_integer_64
						l_den := l_parts[2].to_integer_64
						if l_den /= 0 then
							set_and_reduce (l_num, l_den)
						else
							set_and_reduce (0, 1)
						end
					else
						set_and_reduce (0, 1)
					end
				end
			elseif l_str.has ('.') then
				-- Decimal format: "0.5" -> 1/2
				l_decimal_pos := l_str.index_of ('.', 1)
				l_decimal_places := l_str.count - l_decimal_pos
				-- Remove decimal point
				l_str.remove (l_decimal_pos)
				l_num := l_str.to_integer_64
				l_den := 1
				from i := 1 until i > l_decimal_places loop
					l_den := l_den * 10
					i := i + 1
				end
				set_and_reduce (l_num, l_den)
			else
				-- Integer format: "5"
				l_num := l_str.to_integer_64
				numerator := l_num
				denominator := 1
			end
		ensure
			is_reduced: is_reduced
			denominator_positive: denominator > 0
		end

	make_zero
			-- Create zero (0/1)
		do
			numerator := 0
			denominator := 1
		ensure
			is_zero: is_zero
		end

	make_one
			-- Create one (1/1)
		do
			numerator := 1
			denominator := 1
		ensure
			is_one: numerator = 1 and denominator = 1
		end

feature -- Access

	numerator: INTEGER_64
			-- The numerator (top number)

	denominator: INTEGER_64
			-- The denominator (bottom number), always positive

feature -- Status

	is_zero: BOOLEAN
			-- Is this fraction zero?
		do
			Result := numerator = 0
		ensure
			definition: Result = (numerator = 0)
		end

	is_negative: BOOLEAN
			-- Is this fraction negative?
		do
			Result := numerator < 0
		ensure
			definition: Result = (numerator < 0)
		end

	is_positive: BOOLEAN
			-- Is this fraction positive (not zero, not negative)?
		do
			Result := numerator > 0
		ensure
			definition: Result = (numerator > 0)
		end

	is_integer: BOOLEAN
			-- Is this fraction a whole number?
		do
			Result := denominator = 1
		ensure
			definition: Result = (denominator = 1)
		end

	is_proper: BOOLEAN
			-- Is this a proper fraction (|numerator| < denominator)?
		do
			Result := numerator.abs < denominator
		ensure
			definition: Result = (numerator.abs < denominator)
		end

	is_improper: BOOLEAN
			-- Is this an improper fraction (|numerator| >= denominator)?
		do
			Result := numerator.abs >= denominator
		ensure
			definition: Result = (numerator.abs >= denominator)
		end

	is_reduced: BOOLEAN
			-- Is this fraction in lowest terms?
		do
			Result := gcd (numerator.abs, denominator) = 1 or numerator = 0
		end

	is_unit_fraction: BOOLEAN
			-- Is this a unit fraction (numerator = 1)?
		do
			Result := numerator = 1
		ensure
			definition: Result = (numerator = 1)
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current fraction less than other?
		do
			-- a/b < c/d iff a*d < c*b (when denominators are positive)
			Result := numerator * other.denominator < other.numerator * denominator
		end

	is_equal (other: like Current): BOOLEAN
			-- Are fractions equal?
		do
			-- Since both are reduced and denominators positive, just compare
			Result := numerator = other.numerator and denominator = other.denominator
		end

feature -- Conversion

	to_double: DOUBLE
			-- Convert to double (may lose precision)
		do
			Result := numerator / denominator
		end

	to_integer: INTEGER_64
			-- Convert to integer (truncates)
		do
			Result := numerator // denominator
		end

	whole_part: INTEGER_64
			-- The whole number part of this fraction
		do
			Result := numerator // denominator
		end

	fractional_part: SIMPLE_FRACTION
			-- The fractional part (remainder after removing whole part)
		local
			l_frac_num: INTEGER_64
		do
			l_frac_num := numerator \\ denominator
			if l_frac_num < 0 then
				l_frac_num := l_frac_num.abs
			end
			create Result.make (l_frac_num, denominator)
		ensure
			result_proper: Result.is_proper or Result.is_zero
			result_non_negative: not Result.is_negative
		end

	out: STRING
			-- String representation as "numerator/denominator" or "integer"
		do
			if denominator = 1 then
				Result := numerator.out
			else
				Result := numerator.out + "/" + denominator.out
			end
		end

	to_string: STRING
			-- Same as out
		do
			Result := out
		end

	to_mixed_string: STRING
			-- String representation as mixed number "whole num/den" or "num/den"
		local
			l_whole: INTEGER_64
			l_frac_num: INTEGER_64
		do
			if is_proper or is_zero or is_integer then
				Result := out
			else
				l_whole := whole_part
				l_frac_num := (numerator - l_whole * denominator).abs
				if l_frac_num = 0 then
					Result := l_whole.out
				else
					Result := l_whole.out + " " + l_frac_num.out + "/" + denominator.out
				end
			end
		end

	to_decimal_string (a_places: INTEGER): STRING
			-- Decimal string representation to specified places
		require
			places_non_negative: a_places >= 0
		local
			l_double: DOUBLE
			l_format: FORMAT_DOUBLE
		do
			l_double := to_double
			create l_format.make (10, a_places)
			Result := l_format.formatted (l_double)
			Result.left_adjust
		end

feature -- Arithmetic (Immutable - returns new SIMPLE_FRACTION)

	add alias "+" (other: like Current): SIMPLE_FRACTION
			-- Sum of current and other
		require
			other_not_void: other /= Void
		local
			l_num: INTEGER_64
		do
			-- a/b + c/d = (a*d + c*b) / (b*d)
			l_num := numerator * other.denominator + other.numerator * denominator
			create Result.make (l_num, denominator * other.denominator)
		ensure
			result_not_void: Result /= Void
			result_reduced: Result.is_reduced
		end

	subtract alias "-" (other: like Current): SIMPLE_FRACTION
			-- Difference of current and other
		require
			other_not_void: other /= Void
		local
			l_num: INTEGER_64
		do
			-- a/b - c/d = (a*d - c*b) / (b*d)
			l_num := numerator * other.denominator - other.numerator * denominator
			create Result.make (l_num, denominator * other.denominator)
		ensure
			result_not_void: Result /= Void
			result_reduced: Result.is_reduced
		end

	multiply alias "*" (other: like Current): SIMPLE_FRACTION
			-- Product of current and other
		require
			other_not_void: other /= Void
		do
			-- a/b * c/d = (a*c) / (b*d)
			create Result.make (numerator * other.numerator, denominator * other.denominator)
		ensure
			result_not_void: Result /= Void
			result_reduced: Result.is_reduced
		end

	divide alias "/" (other: like Current): SIMPLE_FRACTION
			-- Quotient of current divided by other
		require
			other_not_void: other /= Void
			other_not_zero: not other.is_zero
		do
			-- a/b / c/d = (a*d) / (b*c)
			create Result.make (numerator * other.denominator, denominator * other.numerator)
		ensure
			result_not_void: Result /= Void
			result_reduced: Result.is_reduced
		end

	negate: SIMPLE_FRACTION
			-- Negated value
		do
			create Result.make (-numerator, denominator)
		ensure
			result_not_void: Result /= Void
			sign_flipped: Result.is_negative /= is_negative or is_zero
		end

	absolute: SIMPLE_FRACTION
			-- Absolute value
		do
			create Result.make (numerator.abs, denominator)
		ensure
			result_not_void: Result /= Void
			result_non_negative: not Result.is_negative
		end

	reciprocal: SIMPLE_FRACTION
			-- Reciprocal (1/this = denominator/numerator)
		require
			not_zero: not is_zero
		do
			create Result.make (denominator, numerator)
		ensure
			result_not_void: Result /= Void
			reciprocal_property: (Current * Result).is_equal (one)
		end

	power (n: INTEGER): SIMPLE_FRACTION
			-- Current raised to integer power n
		local
			l_num, l_den: INTEGER_64
			i: INTEGER
		do
			if n = 0 then
				create Result.make_one
			elseif n > 0 then
				l_num := 1
				l_den := 1
				from i := 1 until i > n loop
					l_num := l_num * numerator
					l_den := l_den * denominator
					i := i + 1
				end
				create Result.make (l_num, l_den)
			else
				-- Negative power: reciprocal raised to positive power
				Result := reciprocal.power (-n)
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Scaling

	scale (a_factor: INTEGER_64): SIMPLE_FRACTION
			-- Multiply by integer factor
		do
			create Result.make (numerator * a_factor, denominator)
		ensure
			result_not_void: Result /= Void
		end

	scale_down (a_factor: INTEGER_64): SIMPLE_FRACTION
			-- Divide by integer factor
		require
			factor_not_zero: a_factor /= 0
		do
			create Result.make (numerator, denominator * a_factor)
		ensure
			result_not_void: Result /= Void
		end

feature -- Factory helpers

	zero: SIMPLE_FRACTION
			-- Zero value
		do
			create Result.make_zero
		ensure
			result_is_zero: Result.is_zero
		end

	one: SIMPLE_FRACTION
			-- One value
		do
			create Result.make_one
		ensure
			result_is_one: Result.numerator = 1 and Result.denominator = 1
		end

	half: SIMPLE_FRACTION
			-- One half (1/2)
		do
			create Result.make (1, 2)
		ensure
			correct: Result.numerator = 1 and Result.denominator = 2
		end

	third: SIMPLE_FRACTION
			-- One third (1/3)
		do
			create Result.make (1, 3)
		ensure
			correct: Result.numerator = 1 and Result.denominator = 3
		end

	quarter: SIMPLE_FRACTION
			-- One quarter (1/4)
		do
			create Result.make (1, 4)
		ensure
			correct: Result.numerator = 1 and Result.denominator = 4
		end

feature -- Common fractions

	halves (n: INTEGER_64): SIMPLE_FRACTION
			-- n halves (n/2)
		do
			create Result.make (n, 2)
		end

	thirds (n: INTEGER_64): SIMPLE_FRACTION
			-- n thirds (n/3)
		do
			create Result.make (n, 3)
		end

	quarters (n: INTEGER_64): SIMPLE_FRACTION
			-- n quarters (n/4)
		do
			create Result.make (n, 4)
		end

	eighths (n: INTEGER_64): SIMPLE_FRACTION
			-- n eighths (n/8)
		do
			create Result.make (n, 8)
		end

	sixteenths (n: INTEGER_64): SIMPLE_FRACTION
			-- n sixteenths (n/16)
		do
			create Result.make (n, 16)
		end

feature {NONE} -- Implementation

	set_and_reduce (a_num, a_den: INTEGER_64)
			-- Set numerator and denominator, reducing to lowest terms
		require
			denominator_not_zero: a_den /= 0
		local
			l_gcd: INTEGER_64
			l_num, l_den: INTEGER_64
		do
			l_num := a_num
			l_den := a_den

			-- Ensure denominator is positive
			if l_den < 0 then
				l_num := -l_num
				l_den := -l_den
			end

			-- Reduce to lowest terms
			if l_num = 0 then
				numerator := 0
				denominator := 1
			else
				l_gcd := gcd (l_num.abs, l_den)
				numerator := l_num // l_gcd
				denominator := l_den // l_gcd
			end
		ensure
			denominator_positive: denominator > 0
			is_reduced: is_reduced
		end

	gcd (a, b: INTEGER_64): INTEGER_64
			-- Greatest common divisor using Euclidean algorithm
		require
			a_non_negative: a >= 0
			b_non_negative: b >= 0
		local
			l_a, l_b, l_temp: INTEGER_64
		do
			l_a := a
			l_b := b
			from
			until
				l_b = 0
			loop
				l_temp := l_b
				l_b := l_a \\ l_b
				l_a := l_temp
			end
			Result := l_a
			if Result = 0 then
				Result := 1
			end
		ensure
			result_positive: Result > 0
		end

invariant
	denominator_positive: denominator > 0
	reduced_form: is_reduced

end
