package Day05;
use AoC2019::Intcomp;
use strict;
use warnings;

sub part1 {
	my ($instructions) = @_;
	my %state = Intcomp::runInstructions($instructions);
	return $state{output};
}

1;
