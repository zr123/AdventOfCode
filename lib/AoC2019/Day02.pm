package Day02;
use AoC2019::Intcomp;
use strict;
use warnings;

sub runWith {
	my ($noun, $verb, $instruction_string) = @_;
	$instruction_string =~ s/^(\d+),\d+,\d+/$1,$noun,$verb/;
	my %state = Intcomp::runInstructions($instruction_string);
	return $state{instructions}[0];
}

sub part1 {
	my ($instruction_string) = @_;
	return runWith(12, 2, $instruction_string);
}

sub part2 {
	my ($goal, $instruction_string) = @_;
	for(my $noun = 0; $noun < 100; $noun++){
		for(my $verb = 0; $verb < 100; $verb++){
			if(runWith($noun, $verb, $instruction_string) == $goal){
				return 100 * $noun + $verb;
			}
		}
	}
}

1;
