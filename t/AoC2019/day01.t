use strict;
use warnings;
use Test::More tests => 5;
use AoC2019::Day01;
use File::Slurp;

my @input = read_file("input/AoC2019/day01.txt");

is(Day01::getFuel(12), 2);
is(Day01::getFuel(14), 2);
is(Day01::getFuel(1969), 654);
is(Day01::getFuel(100756), 33583);
is(Day01::part1(@input), 3229279);
