note
	description: "Tests for SIMPLE_FRACTION"
	author: "Larry Rix"
	testing: "covers"

class
	LIB_TESTS

inherit
	TEST_SET_BASE

feature -- Tests

	test_creation
			-- Test various creation methods
		local
			f: SIMPLE_FRACTION
		do
			create f.default_create
			assert_true ("default_create is zero", f.is_zero)
			assert_true ("default_create = 0/1", f.numerator = 0 and f.denominator = 1)

			create f.make (3, 4)
			assert_integers_equal ("make(3,4) numerator", 3, f.numerator.to_integer_32)
			assert_integers_equal ("make(3,4) denominator", 4, f.denominator.to_integer_32)

			create f.make_integer (5)
			assert_true ("make_integer(5)", f.numerator = 5 and f.denominator = 1)

			create f.make_zero
			assert_true ("make_zero", f.is_zero)

			create f.make_one
			assert_true ("make_one", f.numerator = 1 and f.denominator = 1)
		end

	test_reduction
			-- Test automatic reduction to lowest terms
		local
			f: SIMPLE_FRACTION
		do
			create f.make (2, 4)
			assert_true ("2/4 -> 1/2", f.numerator = 1 and f.denominator = 2)

			create f.make (6, 9)
			assert_true ("6/9 -> 2/3", f.numerator = 2 and f.denominator = 3)

			create f.make (100, 25)
			assert_true ("100/25 -> 4", f.numerator = 4 and f.denominator = 1)

			create f.make (3, -4)
			assert_true ("3/-4 -> -3/4", f.numerator = -3 and f.denominator = 4)

			create f.make (-3, -4)
			assert_true ("-3/-4 -> 3/4", f.numerator = 3 and f.denominator = 4)

			create f.make (0, 5)
			assert_true ("0/5 -> 0/1", f.numerator = 0 and f.denominator = 1)
		end

	test_arithmetic
			-- Test arithmetic operations
		local
			a, b, r: SIMPLE_FRACTION
		do
			create a.make (1, 2)
			create b.make (1, 4)
			r := a + b
			assert_true ("1/2 + 1/4 = 3/4", r.numerator = 3 and r.denominator = 4)

			create a.make (1, 2)
			create b.make (1, 2)
			r := a + b
			assert_true ("1/2 + 1/2 = 1", r.numerator = 1 and r.denominator = 1)

			create a.make (3, 4)
			create b.make (1, 4)
			r := a - b
			assert_true ("3/4 - 1/4 = 1/2", r.numerator = 1 and r.denominator = 2)

			create a.make (2, 3)
			create b.make (3, 4)
			r := a * b
			assert_true ("2/3 * 3/4 = 1/2", r.numerator = 1 and r.denominator = 2)

			create a.make (1, 2)
			create b.make (1, 4)
			r := a / b
			assert_true ("1/2 / 1/4 = 2", r.numerator = 2 and r.denominator = 1)

			create a.make (3, 4)
			r := a.negate
			assert_true ("negate 3/4 = -3/4", r.numerator = -3 and r.denominator = 4)

			create a.make (-3, 4)
			r := a.absolute
			assert_true ("abs(-3/4) = 3/4", r.numerator = 3 and r.denominator = 4)

			create a.make (3, 4)
			r := a.reciprocal
			assert_true ("reciprocal(3/4) = 4/3", r.numerator = 4 and r.denominator = 3)

			create a.make (2, 3)
			r := a.power (2)
			assert_true ("(2/3)^2 = 4/9", r.numerator = 4 and r.denominator = 9)

			create a.make (2, 3)
			r := a.power (-1)
			assert_true ("(2/3)^-1 = 3/2", r.numerator = 3 and r.denominator = 2)
		end

	test_comparison
			-- Test comparison operations
		local
			a, b: SIMPLE_FRACTION
		do
			create a.make (1, 2)
			create b.make (1, 4)
			assert_true ("1/2 > 1/4", a > b)
			assert_true ("1/4 < 1/2", b < a)

			create a.make (2, 4)
			create b.make (1, 2)
			assert_true ("2/4 = 1/2", a.is_equal (b))

			create a.make (3, 4)
			create b.make (2, 3)
			assert_true ("3/4 > 2/3", a > b)

			create a.make (-1, 2)
			create b.make (1, 2)
			assert_true ("-1/2 < 1/2", a < b)
		end

	test_mixed_numbers
			-- Test mixed number creation and output
		local
			f: SIMPLE_FRACTION
		do
			create f.make_mixed (2, 3, 4)
			assert_true ("2 3/4 = 11/4", f.numerator = 11 and f.denominator = 4)

			create f.make (11, 4)
			assert_strings_equal ("11/4 as mixed", "2 3/4", f.to_mixed_string)

			create f.make (3, 4)
			assert_strings_equal ("3/4 mixed string", "3/4", f.to_mixed_string)

			create f.make (4, 1)
			assert_strings_equal ("4/1 mixed string", "4", f.to_mixed_string)

			create f.make (11, 4)
			assert_integers_equal ("whole_part(11/4)", 2, f.whole_part.to_integer_32)

			create f.make (11, 4)
			assert_true ("fractional_part(11/4) = 3/4",
				f.fractional_part.numerator = 3 and f.fractional_part.denominator = 4)

			create f.make_mixed (-2, 3, 4)
			assert_true ("-2 3/4 = -11/4", f.numerator = -11 and f.denominator = 4)
		end

	test_string_parsing
			-- Test string parsing
		local
			f: SIMPLE_FRACTION
		do
			create f.make_from_string ("3/4")
			assert_true ("parse '3/4'", f.numerator = 3 and f.denominator = 4)

			create f.make_from_string ("-1/2")
			assert_true ("parse '-1/2'", f.numerator = -1 and f.denominator = 2)

			create f.make_from_string ("5")
			assert_true ("parse '5'", f.numerator = 5 and f.denominator = 1)

			create f.make_from_string ("2 3/4")
			assert_true ("parse '2 3/4' = 11/4", f.numerator = 11 and f.denominator = 4)

			create f.make_from_string ("0.5")
			assert_true ("parse '0.5' = 1/2", f.numerator = 1 and f.denominator = 2)

			create f.make_from_string ("0.25")
			assert_true ("parse '0.25' = 1/4", f.numerator = 1 and f.denominator = 4)

			create f.make_from_string ("4/8")
			assert_true ("parse '4/8' = 1/2", f.numerator = 1 and f.denominator = 2)
		end

	test_conversion
			-- Test conversion methods
		local
			f: SIMPLE_FRACTION
			d: DOUBLE
		do
			create f.make (1, 2)
			d := f.to_double
			assert_true ("1/2 to_double = 0.5", (d - 0.5).abs < 0.0001)

			create f.make (1, 4)
			d := f.to_double
			assert_true ("1/4 to_double = 0.25", (d - 0.25).abs < 0.0001)

			create f.make (7, 2)
			assert_integers_equal ("7/2 to_integer", 3, f.to_integer.to_integer_32)

			create f.make (3, 4)
			assert_strings_equal ("3/4 out", "3/4", f.out)

			create f.make (5, 1)
			assert_strings_equal ("5/1 out", "5", f.out)
		end

	test_special_cases
			-- Test special cases and edge cases
		local
			f, g: SIMPLE_FRACTION
		do
			create f.make (0, 5)
			assert_true ("0/5 is_zero", f.is_zero)
			assert_integers_equal ("0/5 = 0/1", 1, f.denominator.to_integer_32)

			create f.make (3, 4)
			assert_true ("3/4 is_proper", f.is_proper)
			assert_false ("3/4 not is_improper", f.is_improper)

			create f.make (5, 4)
			assert_true ("5/4 is_improper", f.is_improper)
			assert_false ("5/4 not is_proper", f.is_proper)

			create f.make (1, 4)
			assert_true ("1/4 is_unit_fraction", f.is_unit_fraction)

			create f.make (-3, 4)
			assert_true ("-3/4 is_negative", f.is_negative)

			create f.make (3, 4)
			assert_true ("3/4 is_positive", f.is_positive)

			f := f.half
			assert_true ("half = 1/2", f.numerator = 1 and f.denominator = 2)

			create g.make_one
			f := g.third
			assert_true ("third = 1/3", f.numerator = 1 and f.denominator = 3)

			create g.make_one
			f := g.quarter
			assert_true ("quarter = 1/4", f.numerator = 1 and f.denominator = 4)

			create g.make_one
			f := g.thirds (2)
			assert_true ("thirds(2) = 2/3", f.numerator = 2 and f.denominator = 3)

			create g.make_one
			f := g.eighths (3)
			assert_true ("eighths(3) = 3/8", f.numerator = 3 and f.denominator = 8)
		end

	test_thirds_exactness
			-- The key test: 1/3 + 1/3 + 1/3 = 1 exactly
		local
			third, r: SIMPLE_FRACTION
		do
			create third.make (1, 3)
			r := third + third + third

			assert_true ("1/3 + 1/3 + 1/3 = 1 (EXACTLY)",
				r.numerator = 1 and r.denominator = 1)

			create r.make (1, 7)
			r := r.scale (7)
			assert_true ("1/7 * 7 = 1", r.numerator = 1 and r.denominator = 1)

			create r.make (1, 2)
			r := r + create {SIMPLE_FRACTION}.make (1, 3)
			r := r.scale (6)
			assert_true ("(1/2 + 1/3) * 6 = 5", r.numerator = 5 and r.denominator = 1)
		end

	test_recipes
			-- Test recipe-style calculations
		local
			half_cup, third_cup, quarter_cup, total: SIMPLE_FRACTION
		do
			create half_cup.make (1, 2)
			create third_cup.make (1, 3)
			create quarter_cup.make (1, 4)

			total := half_cup + third_cup + quarter_cup
			assert_true ("1/2 + 1/3 + 1/4 = 13/12",
				total.numerator = 13 and total.denominator = 12)

			total := total.scale (2)
			assert_true ("doubled recipe = 13/6",
				total.numerator = 13 and total.denominator = 6)
		end

end
