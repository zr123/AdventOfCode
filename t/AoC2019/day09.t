use strict;
use warnings;
use Test::More tests => 1;
use AoC2019::Day09;
use File::Slurp;

my $input = read_file("input/AoC2019/day09.txt");

is ( Day09::part1($input), 3335138414, "Part 1 puzzle answer");
