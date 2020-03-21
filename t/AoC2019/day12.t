use strict;
use warnings;
use Test::More tests => 6;
use AoC2019::Day12;
use File::Slurp;

my @input = read_file("input/AoC2019/day12.txt");

my @test_input = ("<x=-1, y=0, z=2>", "<x=2, y=-10, z=-7>", "<x=4, y=-8, z=8>", "<x=3, y=5, z=-1>");

is_deeply( [Day12::loadScan(@test_input)],
	[
		{"x" => -1, "y" => 0, "z" => 2, "x_vel" => 0, "y_vel" => 0, "z_vel" => 0}, 
		{"x" => 2, "y" => -10, "z" => -7, "x_vel" => 0, "y_vel" => 0, "z_vel" => 0},
		{"x" => 4, "y" => -8, "z" => 8, "x_vel" => 0, "y_vel" => 0, "z_vel" => 0},
		{"x" => 3, "y" => 5, "z" => -1, "x_vel" => 0, "y_vel" => 0, "z_vel" => 0}
	], "For example, suppose your scan reveals the following positions");

my @moons = Day12::loadScan(@test_input);
is_deeply( [Day12::sumulateTimeStep(@moons)],
	[
		{"x" => 2, "y" => -1, "z" => 1, "x_vel" => 3, "y_vel" => -1, "z_vel" => -1}, 
		{"x" => 3, "y" => -7, "z" => -4, "x_vel" => 1, "y_vel" => 3, "z_vel" => 3},
		{"x" => 1, "y" => -7, "z" => 5, "x_vel" => -3, "y_vel" => 1, "z_vel" => -3},
		{"x" => 2, "y" => 2, "z" => 0, "x_vel" => -1, "y_vel" => -3, "z_vel" => 1}
	], "Simulating the motion of these moons would produce the following: After 1 step:");

is( Day12::calcEnergy((
		{"x" => 2, "y" => 1, "z" => -3, "x_vel" => -3, "y_vel" => -2, "z_vel" => 1}, 
		{"x" => 1, "y" => -8, "z" => 0, "x_vel" => -1, "y_vel" => 1, "z_vel" => 3},
		{"x" => 3, "y" => -6, "z" => 1, "x_vel" => 3, "y_vel" => 2, "z_vel" => -3},
		{"x" => 2, "y" => 0, "z" => 4, "x_vel" => 1, "y_vel" => -1, "z_vel" => -1}
	)), 179, "Sum of total energy: 36 + 45 + 80 + 18 = 179");



is( Day12::getEnergyAfterXTimesSteps(10, @test_input), 179, "In the above example, adding together the total energy for all moons after 10 steps produces the total energy in the system, 179.");

@test_input = ("<x=-8, y=-10, z=0>", "<x=5, y=5, z=10>", "<x=2, y=-7, z=3>", "<x=9, y=-8, z=-3>");
is( Day12::getEnergyAfterXTimesSteps(100, @test_input), 1940, "Energy after 100 steps: Sum of total energy: 290 + 608 + 574 + 468 = 1940");

is( Day12::part1(@input), 10664, "Part 1 puzzle answer");
