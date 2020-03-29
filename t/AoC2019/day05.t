use strict;
use warnings;
use Test::More tests => 2;
use AoC2019::Day05;
use File::Slurp;

my $input = read_file("input/AoC2019/day05.txt");

is( Day05::part1($input), 13346482, "Part 1 puzzle answer");

is( Day05::part2($input), 12111395, "Part 2 puzzle answer");
