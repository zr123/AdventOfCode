use strict;
use warnings;
use Test::More tests => 25;
use AoC2019::Intcomp;


is_deeply( Intcomp::decode("1,1,1,4,99,5,6,0,99"), [1,1,1,4,99,5,6,0,99]);

my %state = (pos => 0, instructions => [1,9,10,3,2,3,11,0,99,30,40,50]);
is( Intcomp::processOpcode(\%state), 1);
is_deeply( $state{instructions}, [1,9,10,70,2,3,11,0,99,30,40,50], "To handle this opcode, you first need to get the values at the input positions: position 9 contains 30, and position 10 contains 40. Add these numbers together to get 70. Then, store this value at the output position; here, the output position (3) is at position 3, so it overwrites itself.");

%state = (pos => 4, instructions => [1,9,10,70,2,3,11,0,99,30,40,50]);
is( Intcomp::processOpcode(\%state), 2);
is_deeply( $state{instructions}, [3500,9,10,70,2,3,11,0,99,30,40,50], "The inputs are at positions 3 and 11; these positions contain 70 and 50 respectively. Multiplying these produces 3500; this is stored at position 0");

%state = (pos => 8, instructions => [3500,9,10,70,2,3,11,0,99,30,40,50]);
is( Intcomp::processOpcode(\%state), 99);
is_deeply( $state{instructions}, [3500,9,10,70,2,3,11,0,99,30,40,50], "Stepping forward 4 more positions arrives at opcode 99, halting the program.");

%state = Intcomp::runInstructions("1,9,10,3,2,3,11,0,99,30,40,50");
is_deeply( $state{instructions}, [3500,9,10,70,2,3,11,0,99,30,40,50], "For example, suppose you have the following program: 1,9,10,3,2,3,11,0,99,30,40,50 ... Afterward, the program looks like this: 3500,9,10,70,2,3,11,0,99,30,40,50");

%state = Intcomp::runInstructions("1,0,0,0,99");
is_deeply( $state{instructions}, [2,0,0,0,99], "1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2)");

%state = Intcomp::runInstructions("2,3,0,3,99");
is_deeply( $state{instructions}, [2,3,0,6,99], "2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6).");

%state = Intcomp::runInstructions("2,4,4,5,99,0");
is_deeply( $state{instructions}, [2,4,4,5,99,9801], "2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801).");

%state = Intcomp::runInstructions("1,1,1,4,99,5,6,0,99");
is_deeply( $state{instructions}, [30,1,1,4,2,5,6,0,99], "1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99.");

%state = Intcomp::runInstructions("3,9,8,9,10,9,4,9,99,-1,8", 0);
is ( $state{output}[0], 0, "Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).");

%state = Intcomp::runInstructions("3,9,7,9,10,9,4,9,99,-1,8", 0);
is ( $state{output}[0], 1, "Using position mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).");

%state = Intcomp::runInstructions("3,3,1108,-1,8,3,4,3,99", 0);
is ( $state{output}[0], 0, "Using immediate mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).");

%state = Intcomp::runInstructions("3,3,1107,-1,8,3,4,3,99", 0);
is ( $state{output}[0], 1, "Using immediate mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).");

%state = Intcomp::runInstructions("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 0);
is ( $state{output}[0], 0, "Here are some jump tests that take an input, then output 0 if the input was zero or 1 if the input was non-zero: (using position mode)");

%state = Intcomp::runInstructions("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", 0);
is ( $state{output}[0], 0, "Here are some jump tests that take an input, then output 0 if the input was zero or 1 if the input was non-zero: (using immediate mode)");

is_deeply( [Intcomp::decodeOpcode("1002")], ["02", 0, 1, 0], "For instruction 1002 the rightmost two digits of the first value, 02, indicate opcode 2, multiplication. Then, going right to left, the parameter modes are 0 (hundreds digit), 1 (thousands digit), and 0 (ten-thousands digit, not present and therefore zero)");

my $program = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99";
%state = Intcomp::runInstructions( $program, 1);
is( $state{output}[0], 999, "The program will then output 999 if the input value is below 8 ...");
%state = Intcomp::runInstructions( $program, 8);
is( $state{output}[0], 1000, "output 1000 if the input value is equal to 8 ...");
%state = Intcomp::runInstructions( $program, 10);
is( $state{output}[0], 1001, "or output 1001 if the input value is greater than 8.");

###
# Day09 - Relative mode, multiple output, opcode 09
###

# following tests causes a 'uninitialized value in addition (+)' warning
%state = Intcomp::runInstructions( "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99");
is_deeply( $state{output}, [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99], "... takes no input and produces a copy of itself as output");

%state = Intcomp::runInstructions( "1102,34915192,34915192,7,4,7,99,0");
is( $state{output}[0], 1219070632396864, "... should output a 16-digit numbe");
%state = Intcomp::runInstructions( "104,1125899906842624,99");
is( $state{output}[0], 1125899906842624, "... should output the large number in the middle");

