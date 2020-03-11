use strict;
use warnings;
use Test::More tests => 7;
use AoC2019::Day03;
use File::Slurp;

my @input = read_file("input/AoC2019/day03.txt");

my $mapref = Day03::createWiring("R8,U5,L5,D3", "U7,R6,D4,L4");
is( $mapref->{"3 3"}, 3);
is( $mapref->{"6 5"}, 3);

is( Day03::manhattenDistance("3 3"), 6);

is( Day03::part1("R8,U5,L5,D3", "U7,R6,D4,L4"), 6);
is( Day03::part1("R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"), 159);
is( Day03::part1("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"), 135);

is( Day03::part1(@input), 1195);
