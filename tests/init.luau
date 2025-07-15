local levenshtein = require("@src")
local TEST, CASE, CHECK, FINISH = require("@vendor/testkit").test()

TEST("levenshtein distance", function()
	CASE("flaw lawn")
	CHECK(levenshtein("flaw", "lawn") == 2)

	CASE("empty string")
	CHECK(levenshtein("", "") == 0)

	CASE("identical string")
	CHECK(levenshtein("equality", "equality") == 0)
end)

assert(FINISH())
