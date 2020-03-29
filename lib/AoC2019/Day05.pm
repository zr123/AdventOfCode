package Day05;
use AoC2019::Intcomp;
use strict;
use warnings;

sub part1 {
	my ($instructions) = @_;
	my %state = Intcomp::runInstructions($instructions, 1);
	return $state{output};
}

sub part2 {
	my ($instructions) = @_;
	my %state = Intcomp::runInstructions($instructions, 5);
	return $state{output};
}

1;
