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
is_deeply( \@instructions, [1,9,10,70,2,3,11,0,99,30,40,50], "To handle this opcode, you first need to get the values at the input positions: position 9 contains 30, and position 10 contains 40. Add these numbers together to get 70. Then, store this value at the output position; here, the output position (3) is at position 3, so it overwrites itself.");

@instructions = (1,9,10,70,2,3,11,0,99,30,40,50);
is( Day02::processOpcode(4, \@instructions), 2);
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50], "The inputs are at positions 3 and 11; these positions contain 70 and 50 respectively. Multiplying these produces 3500; this is stored at position 0");

@instructions = (3500,9,10,70,2,3,11,0,99,30,40,50);
is( Day02::processOpcode(8, \@instructions), 99);
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50], "Stepping forward 4 more positions arrives at opcode 99, halting the program.");

@instructions = Day02::runInstructions("1,9,10,3,2,3,11,0,99,30,40,50");
is_deeply( \@instructions, [3500,9,10,70,2,3,11,0,99,30,40,50], "For example, suppose you have the following program: 1,9,10,3,2,3,11,0,99,30,40,50 ... Afterward, the program looks like this: 3500,9,10,70,2,3,11,0,99,30,40,50");
@instructions = Day02::runInstructions("1,0,0,0,99");
is_deeply( \@instructions, [2,0,0,0,99], "1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2)");
@instructions = Day02::runInstructions("2,3,0,3,99");
is_deeply( \@instructions, [2,3,0,6,99], "2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6).");
@instructions = Day02::runInstructions("2,4,4,5,99,0");
is_deeply( \@instructions, [2,4,4,5,99,9801], "2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801).");
@instructions = Day02::runInstructions("1,1,1,4,99,5,6,0,99");
is_deeply( \@instructions, [30,1,1,4,2,5,6,0,99], "1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99.");

is( Day02::part1($input), 4090689, "Part 1 puzzle answer");

is( Day02::part2(19690720, $input), 7733, "Part 2 puzzle answer");
