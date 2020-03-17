use strict;
use warnings;
use Test::More tests => 6;
use AoC2019::Day06;
use File::Slurp;

my @input = read_file("input/AoC2019/day06.txt");

my @test_input = ("COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L");

my %orbits = Day06::getHashedOrbitMap(@test_input);
is( scalar(%orbits), 8);

my %orbitCounts = Day06::getOrbitCounts(%orbits);
is( $orbitCounts{"D"}, 3);
is( $orbitCounts{"L"}, 7);
is( $orbitCounts{"COM"}, 0);

is ( Day06::part1(@test_input), 42);

is ( Day06::part1(@input), 278744);
