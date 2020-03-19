use strict;
use warnings;
use Test::More tests => 5;
use AoC2019::Day08;
use File::Slurp;

my $input = read_file("input/AoC2019/day08.txt");

is_deeply( [Day08::splitLayers("123456789012", 2, 3)], ["123456", "789012"], "For example, given an image 3 pixels wide and 2 pixels tall, the image data 123456789012 corresponds to the following image layers: Layer 1: 123456 Layer 2: 789012");

is( Day08::countDigits("123456789012", 1), 2);

is( Day08::part1($input), 1806, "Part 1 puzzle answer");

is( Day08::generatePicture("0222112222120000", 2, 2), "0110", "given an image 2 pixels wide and 2 pixels tall, the image data 0222112222120000: the final image looks like this: 0110");

is( Day08::part2($input), "JAFRA", "Part 2 puzzle answer");
