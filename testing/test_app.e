note
	description: "Test application for SIMPLE_FRACTION"
	author: "Larry Rix"

class
	TEST_APP

create
	make

feature {NONE} -- Initialization

	make
			-- Run the tests.
		do
			create tests
			print ("Running SIMPLE_FRACTION tests...%N%N")

			passed := 0
			failed := 0

			run_test (agent tests.test_creation, "test_creation")
			run_test (agent tests.test_reduction, "test_reduction")
			run_test (agent tests.test_arithmetic, "test_arithmetic")
			run_test (agent tests.test_comparison, "test_comparison")
			run_test (agent tests.test_mixed_numbers, "test_mixed_numbers")
			run_test (agent tests.test_string_parsing, "test_string_parsing")
			run_test (agent tests.test_conversion, "test_conversion")
			run_test (agent tests.test_special_cases, "test_special_cases")
			run_test (agent tests.test_thirds_exactness, "test_thirds_exactness")
			run_test (agent tests.test_recipes, "test_recipes")

			print ("%N========================%N")
			print ("Results: " + passed.out + " passed, " + failed.out + " failed%N")

			if failed > 0 then
				print ("TESTS FAILED%N")
			else
				print ("ALL TESTS PASSED%N")
			end
		end

feature {NONE} -- Implementation

	tests: LIB_TESTS

	passed: INTEGER
	failed: INTEGER

	run_test (a_test: PROCEDURE; a_name: STRING)
			-- Run a single test and update counters.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				a_test.call (Void)
				print ("  PASS: " + a_name + "%N")
				passed := passed + 1
			end
		rescue
			print ("  FAIL: " + a_name + "%N")
			failed := failed + 1
			l_retried := True
			retry
		end

end
