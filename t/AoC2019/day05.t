use strict;
use warnings;
use Test::More tests => 1;
use AoC2019::Day05;
use File::Slurp;

my $input = read_file("input/AoC2019/day05.txt");

is( Day05::part1($input), 13346482, "Part 1 puzzle answer");
