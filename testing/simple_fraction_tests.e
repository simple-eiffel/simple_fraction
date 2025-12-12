note
	description: "Tests for SIMPLE_FRACTION"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_FRACTION_TESTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run tests
		do
			print ("=== SIMPLE_FRACTION Tests ===%N%N")

			test_creation
			test_reduction
			test_arithmetic
			test_comparison
			test_mixed_numbers
			test_string_parsing
			test_conversion
			test_special_cases
			test_thirds_exactness
			test_recipes

			print ("%N=== All Tests Complete ===%N")
			print ("Passed: " + passed.out + "%N")
			print ("Failed: " + failed.out + "%N")
		end

feature -- Test counts

	passed: INTEGER
	failed: INTEGER

feature -- Tests

	test_creation
			-- Test various creation methods
		local
			f: SIMPLE_FRACTION
		do
			print ("--- Creation Tests ---%N")

			-- Default creates zero
			create f.default_create
			check_result ("default_create is zero", f.is_zero)
			check_result ("default_create = 0/1", f.numerator = 0 and f.denominator = 1)

			-- make with numerator/denominator
			create f.make (3, 4)
			check_result ("make(3,4) numerator", f.numerator = 3)
			check_result ("make(3,4) denominator", f.denominator = 4)

			-- make_integer
			create f.make_integer (5)
			check_result ("make_integer(5)", f.numerator = 5 and f.denominator = 1)

			-- make_zero
			create f.make_zero
			check_result ("make_zero", f.is_zero)

			-- make_one
			create f.make_one
			check_result ("make_one", f.numerator = 1 and f.denominator = 1)

			print ("%N")
		end

	test_reduction
			-- Test automatic reduction to lowest terms
		local
			f: SIMPLE_FRACTION
		do
			print ("--- Reduction Tests ---%N")

			-- 2/4 reduces to 1/2
			create f.make (2, 4)
			check_result ("2/4 -> 1/2", f.numerator = 1 and f.denominator = 2)

			-- 6/9 reduces to 2/3
			create f.make (6, 9)
			check_result ("6/9 -> 2/3", f.numerator = 2 and f.denominator = 3)

			-- 100/25 reduces to 4/1
			create f.make (100, 25)
			check_result ("100/25 -> 4", f.numerator = 4 and f.denominator = 1)

			-- Negative denominator normalized
			create f.make (3, -4)
			check_result ("3/-4 -> -3/4", f.numerator = -3 and f.denominator = 4)

			-- Both negative
			create f.make (-3, -4)
			check_result ("-3/-4 -> 3/4", f.numerator = 3 and f.denominator = 4)

			-- 0/5 reduces to 0/1
			create f.make (0, 5)
			check_result ("0/5 -> 0/1", f.numerator = 0 and f.denominator = 1)

			print ("%N")
		end

	test_arithmetic
			-- Test arithmetic operations
		local
			a, b, r: SIMPLE_FRACTION
		do
			print ("--- Arithmetic Tests ---%N")

			-- Addition: 1/2 + 1/4 = 3/4
			create a.make (1, 2)
			create b.make (1, 4)
			r := a + b
			check_result ("1/2 + 1/4 = 3/4", r.numerator = 3 and r.denominator = 4)

			-- Addition: 1/2 + 1/2 = 1
			create a.make (1, 2)
			create b.make (1, 2)
			r := a + b
			check_result ("1/2 + 1/2 = 1", r.numerator = 1 and r.denominator = 1)

			-- Subtraction: 3/4 - 1/4 = 1/2
			create a.make (3, 4)
			create b.make (1, 4)
			r := a - b
			check_result ("3/4 - 1/4 = 1/2", r.numerator = 1 and r.denominator = 2)

			-- Multiplication: 2/3 * 3/4 = 1/2
			create a.make (2, 3)
			create b.make (3, 4)
			r := a * b
			check_result ("2/3 * 3/4 = 1/2", r.numerator = 1 and r.denominator = 2)

			-- Division: 1/2 / 1/4 = 2
			create a.make (1, 2)
			create b.make (1, 4)
			r := a / b
			check_result ("1/2 / 1/4 = 2", r.numerator = 2 and r.denominator = 1)

			-- Negation
			create a.make (3, 4)
			r := a.negate
			check_result ("negate 3/4 = -3/4", r.numerator = -3 and r.denominator = 4)

			-- Absolute value
			create a.make (-3, 4)
			r := a.absolute
			check_result ("abs(-3/4) = 3/4", r.numerator = 3 and r.denominator = 4)

			-- Reciprocal
			create a.make (3, 4)
			r := a.reciprocal
			check_result ("reciprocal(3/4) = 4/3", r.numerator = 4 and r.denominator = 3)

			-- Power
			create a.make (2, 3)
			r := a.power (2)
			check_result ("(2/3)^2 = 4/9", r.numerator = 4 and r.denominator = 9)

			-- Negative power
			create a.make (2, 3)
			r := a.power (-1)
			check_result ("(2/3)^-1 = 3/2", r.numerator = 3 and r.denominator = 2)

			print ("%N")
		end

	test_comparison
			-- Test comparison operations
		local
			a, b: SIMPLE_FRACTION
		do
			print ("--- Comparison Tests ---%N")

			create a.make (1, 2)
			create b.make (1, 4)
			check_result ("1/2 > 1/4", a > b)
			check_result ("1/4 < 1/2", b < a)

			create a.make (2, 4)
			create b.make (1, 2)
			check_result ("2/4 = 1/2", a.is_equal (b))

			create a.make (3, 4)
			create b.make (2, 3)
			check_result ("3/4 > 2/3", a > b)

			create a.make (-1, 2)
			create b.make (1, 2)
			check_result ("-1/2 < 1/2", a < b)

			print ("%N")
		end

	test_mixed_numbers
			-- Test mixed number creation and output
		local
			f: SIMPLE_FRACTION
		do
			print ("--- Mixed Number Tests ---%N")

			-- 2 3/4 = 11/4
			create f.make_mixed (2, 3, 4)
			check_result ("2 3/4 = 11/4", f.numerator = 11 and f.denominator = 4)

			-- Mixed string output
			create f.make (11, 4)
			check_result ("11/4 as mixed = '2 3/4'", f.to_mixed_string.is_equal ("2 3/4"))

			-- Proper fraction stays as is
			create f.make (3, 4)
			check_result ("3/4 mixed string = '3/4'", f.to_mixed_string.is_equal ("3/4"))

			-- Integer stays as is
			create f.make (4, 1)
			check_result ("4/1 mixed string = '4'", f.to_mixed_string.is_equal ("4"))

			-- Whole part extraction
			create f.make (11, 4)
			check_result ("whole_part(11/4) = 2", f.whole_part = 2)

			-- Fractional part extraction
			create f.make (11, 4)
			check_result ("fractional_part(11/4) = 3/4",
				f.fractional_part.numerator = 3 and f.fractional_part.denominator = 4)

			-- Negative mixed: -2 3/4 = -11/4
			create f.make_mixed (-2, 3, 4)
			check_result ("-2 3/4 = -11/4", f.numerator = -11 and f.denominator = 4)

			print ("%N")
		end

	test_string_parsing
			-- Test string parsing
		local
			f: SIMPLE_FRACTION
		do
			print ("--- String Parsing Tests ---%N")

			-- Simple fraction
			create f.make_from_string ("3/4")
			check_result ("parse '3/4'", f.numerator = 3 and f.denominator = 4)

			-- Negative fraction
			create f.make_from_string ("-1/2")
			check_result ("parse '-1/2'", f.numerator = -1 and f.denominator = 2)

			-- Integer
			create f.make_from_string ("5")
			check_result ("parse '5'", f.numerator = 5 and f.denominator = 1)

			-- Mixed number
			create f.make_from_string ("2 3/4")
			check_result ("parse '2 3/4' = 11/4", f.numerator = 11 and f.denominator = 4)

			-- Decimal
			create f.make_from_string ("0.5")
			check_result ("parse '0.5' = 1/2", f.numerator = 1 and f.denominator = 2)

			-- Decimal with reduction
			create f.make_from_string ("0.25")
			check_result ("parse '0.25' = 1/4", f.numerator = 1 and f.denominator = 4)

			-- Fraction needing reduction
			create f.make_from_string ("4/8")
			check_result ("parse '4/8' = 1/2", f.numerator = 1 and f.denominator = 2)

			print ("%N")
		end

	test_conversion
			-- Test conversion methods
		local
			f: SIMPLE_FRACTION
			d: DOUBLE
		do
			print ("--- Conversion Tests ---%N")

			create f.make (1, 2)
			d := f.to_double
			check_result ("1/2 to_double = 0.5", (d - 0.5).abs < 0.0001)

			create f.make (1, 4)
			d := f.to_double
			check_result ("1/4 to_double = 0.25", (d - 0.25).abs < 0.0001)

			create f.make (7, 2)
			check_result ("7/2 to_integer = 3", f.to_integer = 3)

			create f.make (3, 4)
			check_result ("3/4 out = '3/4'", f.out.is_equal ("3/4"))

			create f.make (5, 1)
			check_result ("5/1 out = '5'", f.out.is_equal ("5"))

			print ("%N")
		end

	test_special_cases
			-- Test special cases and edge cases
		local
			f, g: SIMPLE_FRACTION
		do
			print ("--- Special Cases Tests ---%N")

			-- Zero handling
			create f.make (0, 5)
			check_result ("0/5 is_zero", f.is_zero)
			check_result ("0/5 = 0/1", f.denominator = 1)

			-- Status queries
			create f.make (3, 4)
			check_result ("3/4 is_proper", f.is_proper)
			check_result ("3/4 not is_improper", not f.is_improper)

			create f.make (5, 4)
			check_result ("5/4 is_improper", f.is_improper)
			check_result ("5/4 not is_proper", not f.is_proper)

			create f.make (1, 4)
			check_result ("1/4 is_unit_fraction", f.is_unit_fraction)

			create f.make (-3, 4)
			check_result ("-3/4 is_negative", f.is_negative)

			create f.make (3, 4)
			check_result ("3/4 is_positive", f.is_positive)

			-- Factory helpers
			f := f.half
			check_result ("half = 1/2", f.numerator = 1 and f.denominator = 2)

			create g.make_one
			f := g.third
			check_result ("third = 1/3", f.numerator = 1 and f.denominator = 3)

			create g.make_one
			f := g.quarter
			check_result ("quarter = 1/4", f.numerator = 1 and f.denominator = 4)

			-- Common fractions
			create g.make_one
			f := g.thirds (2)
			check_result ("thirds(2) = 2/3", f.numerator = 2 and f.denominator = 3)

			create g.make_one
			f := g.eighths (3)
			check_result ("eighths(3) = 3/8", f.numerator = 3 and f.denominator = 8)

			print ("%N")
		end

	test_thirds_exactness
			-- The key test: 1/3 + 1/3 + 1/3 = 1 exactly
		local
			third, r: SIMPLE_FRACTION
		do
			print ("--- Exactness Tests (The Whole Point!) ---%N")

			create third.make (1, 3)
			r := third + third + third

			check_result ("1/3 + 1/3 + 1/3 = 1 (EXACTLY)",
				r.numerator = 1 and r.denominator = 1)

			print ("  1/3 + 1/3 + 1/3 = " + r.out + " (exact!)%N")
			print ("  Compare to DOUBLE: " + ((1.0/3.0) + (1.0/3.0) + (1.0/3.0)).out + "%N")

			-- 1/7 * 7 = 1
			create r.make (1, 7)
			r := r.scale (7)
			check_result ("1/7 * 7 = 1", r.numerator = 1 and r.denominator = 1)

			-- Complex calculation
			-- (1/2 + 1/3) * 6 = 5
			create r.make (1, 2)
			r := r + create {SIMPLE_FRACTION}.make (1, 3)
			r := r.scale (6)
			check_result ("(1/2 + 1/3) * 6 = 5", r.numerator = 5 and r.denominator = 1)

			print ("%N")
		end

	test_recipes
			-- Test recipe-style calculations
		local
			half_cup, third_cup, quarter_cup, total: SIMPLE_FRACTION
		do
			print ("--- Recipe Tests ---%N")

			-- Recipe: 1/2 cup + 1/3 cup + 1/4 cup = ?
			create half_cup.make (1, 2)
			create third_cup.make (1, 3)
			create quarter_cup.make (1, 4)

			total := half_cup + third_cup + quarter_cup
			check_result ("1/2 + 1/3 + 1/4 = 13/12",
				total.numerator = 13 and total.denominator = 12)

			print ("  Recipe total: " + total.out + " = " + total.to_mixed_string + " cups%N")

			-- Double the recipe
			total := total.scale (2)
			check_result ("doubled recipe = 13/6",
				total.numerator = 13 and total.denominator = 6)

			print ("  Doubled: " + total.out + " = " + total.to_mixed_string + " cups%N")

			print ("%N")
		end

feature {NONE} -- Implementation

	check_result (a_name: STRING; a_condition: BOOLEAN)
			-- Check test result
		do
			if a_condition then
				print ("  PASS: " + a_name + "%N")
				passed := passed + 1
			else
				print ("  FAIL: " + a_name + "%N")
				failed := failed + 1
			end
		end

end
