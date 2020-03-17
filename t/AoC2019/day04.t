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

is( Day04::checkNumber(111111), 1);
is( Day04::checkNumber(223450), 0);
is( Day04::checkNumber(123789), 0);

is( Day04::part1(@input), 1767);

is( Day04::checkDoublesButNotTriples(112233), 1);
is( Day04::checkDoublesButNotTriples(123444), 0);
is( Day04::checkDoublesButNotTriples(111122), 1);

is( Day04::part2(@input), 1192);
