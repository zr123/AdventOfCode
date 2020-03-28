use strict;
use warnings;
use Test::More tests => 2;
use AoC2019::Day02;
use File::Slurp;

my $input = read_file("input/AoC2019/day02.txt");

is( Day02::part1($input), 4090689, "Part 1 puzzle answer");

is( Day02::part2(19690720, $input), 7733, "Part 2 puzzle answer");
