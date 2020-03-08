use strict;
use warnings;
use Test::More tests => 15;
use AoC2019::Day02;
use File::Slurp;

my $input = read_file("input/AoC2019/day02.txt");

my @a = Day02::decode("1,1,1,4,99,5,6,0,99");
is_deeply( \@a, [1,1,1,4,99,5,6,0,99]);
is( Day02::encode((1,1,1,4,99,5,6,0,99)), "1,1,1,4,99,5,6,0,99");

my @instructions = (1,9,10,3,2,3,11,0,99,30,40,50);
is( Day02::processOpcode(0, \@instructions), 1);
is_deeply( \@instructions, [1,9,10,70,2,3,11,0,99,30,40,50]);

@instructions = (1,9,10,70,2,3,11,0,99,30,40,50);
is( Day02::processOpcode(4, \@instructions), 2);
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50]);

@instructions = (3500,9,10,70,2,3,11,0,99,30,40,50);
is( Day02::processOpcode(8, \@instructions), 99);
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50]);

@instructions = Day02::runInstructions("1,9,10,3,2,3,11,0,99,30,40,50");
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50]);
@instructions = Day02::runInstructions("1,0,0,0,99");
is_deeply( \@instructions, [2,0,0,0,99]);
@instructions = Day02::runInstructions("2,3,0,3,99");
is_deeply( \@instructions, [2,3,0,6,99]);
@instructions = Day02::runInstructions("2,4,4,5,99,0");
is_deeply( \@instructions, [2,4,4,5,99,9801]);
@instructions = Day02::runInstructions("1,1,1,4,99,5,6,0,99");
is_deeply( \@instructions, [30,1,1,4,2,5,6,0,99]);

is( Day02::part1($input), 4090689);

is( Day02::part2(19690720, $input), 7733);
