use strict;
use warnings;
use Test::More tests => 14;
use AoC2019::Day04;

my @input = (145852, 616942);

is( Day04::checkDoubles(111111), 1);
is( Day04::checkDoubles(223450), 1);
is( Day04::checkDoubles(123789), 0);

is( Day04::checkAscending(111111), 1);
is( Day04::checkAscending(223450), 0);
is( Day04::checkAscending(123789), 1);

is( Day04::checkNumber(111111), 1, "111111 meets these criteria (double 11, never decreases).");
is( Day04::checkNumber(223450), 0, "223450 does not meet these criteria (decreasing pair of digits 50).");
is( Day04::checkNumber(123789), 0, "123789 does not meet these criteria (no double).");

is( Day04::part1(@input), 1767, "Part 1 puzzle answer");

is( Day04::checkDoublesButNotTriples(112233), 1, "112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.");
is( Day04::checkDoublesButNotTriples(123444), 0, "123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).");
is( Day04::checkDoublesButNotTriples(111122), 1, "111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).");

is( Day04::part2(@input), 1192, "Part 2 puzzle answer");
