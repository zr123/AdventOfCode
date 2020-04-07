package Day07;
use lib '..';
use AoC2019::Intcomp;
use List::Permutor;
use strict;
use warnings;


sub runAmplifiers{
	my ($program, @phaseSetting) = @_;
	my ($A, $B, $C, $D, $E) = @phaseSetting;
	my %state = Intcomp::runInstructions($program, ($A, 0));
	%state = Intcomp::runInstructions($program, ($B, $state{output}));
	%state = Intcomp::runInstructions($program, ($C, $state{output}));
	%state = Intcomp::runInstructions($program, ($D, $state{output}));
	%state = Intcomp::runInstructions($program, ($E, $state{output}));
	return $state{output};
}

sub findHighestThrusterSignal{
	my ($program) = @_;
	my $maxValue = 0;
	my $phase = List::Permutor->new(0, 1, 2, 3, 4);
	while ( my @phaseSetting = $phase->next() ) {
		my $value = runAmplifiers($program, @phaseSetting);
		$maxValue = $value if($value > $maxValue);
	}
	return $maxValue;
}

sub part1 {
	my ($program) = @_;
	return findHighestThrusterSignal($program);
}

1;
