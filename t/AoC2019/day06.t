use strict;
use warnings;
use Test::More tests => 11;
use AoC2019::Day06;
use File::Slurp;

my @input = read_file("input/AoC2019/day06.txt");

my @test_input = ("COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L");

my %orbits = Day06::getHashedOrbitMap(@test_input);
is( keys(%orbits), 8, "There are 8 branching nodes");

my %orbitCounts = Day06::getOrbitCounts(%orbits);
is( $orbitCounts{"D"}, 3, "D directly orbits C and indirectly orbits B and COM, a total of 3 orbits.");
is( $orbitCounts{"L"}, 7, "L directly orbits K and indirectly orbits J, E, D, C, B, and COM, a total of 7 orbits.");
is( $orbitCounts{"COM"}, 0, "COM orbits nothing.");

is ( Day06::part1(@test_input), 42, "The total number of direct and indirect orbits in this example is 42.");

is ( Day06::part1(@input), 278744, "Part 1 puzzle answer");

@test_input = ("COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L", "K)YOU", "I)SAN");

is( Day06::getOrbitPath("YOU", @test_input), "COM)B)C)D)E)J)K)YOU");
is( Day06::getOrbitPath("SAN", @test_input), "COM)B)C)D)I)SAN");

is( Day06::findFirstCommonPlanet("COM)B)C)D)E)J)K)YOU", "COM)B)C)D)I)SAN"), "D");

is( Day06::part2(@test_input), 4, "To move from K to I, a minimum of 4 orbital transfers are required.");

is( Day06::part2(@input), 475, "Part 2 puzzle answer");
