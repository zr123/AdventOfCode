package Day09;
use lib '..';
use AoC2019::Intcomp;
use List::Permutor;
use strict;
use warnings;

sub part1 {
	my ($instructions) = @_;
	my %state = Intcomp::runInstructions($instructions, 1);
	return $state{output}[0];
}

1;
