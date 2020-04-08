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

sub runAmplifierFeedbackLoop {
	my ($program, @phaseSetting) = @_;
	my ($A, $B, $C, $D, $E) = @phaseSetting;
	my %ampA = Intcomp::runInstructions($program, ($A, 0));
	my %ampB = Intcomp::runInstructions($program, ($B, $ampA{output}));
	my %ampC = Intcomp::runInstructions($program, ($C, $ampB{output}));
	my %ampD = Intcomp::runInstructions($program, ($D, $ampC{output}));
	my %ampE = Intcomp::runInstructions($program, ($E, $ampD{output}));

	while($ampA{exitstate} ne "exit" || $ampB{exitstate} ne "exit" || $ampC{exitstate} ne "exit" || $ampD{exitstate} ne "exit" || $ampE{exitstate} ne "exit"){
		Intcomp::continueExecution(\%ampA, $ampE{output});
		Intcomp::continueExecution(\%ampB, $ampA{output});
		Intcomp::continueExecution(\%ampC, $ampB{output});
		Intcomp::continueExecution(\%ampD, $ampC{output});
		Intcomp::continueExecution(\%ampE, $ampD{output});
	}
	return $ampE{output};
}

sub findHighestFeedbackLoopThrusterSignal{
	my ($program) = @_;
	my $maxValue = 0;
	my $phase = List::Permutor->new(5, 6, 7, 8, 9);
	while ( my @phaseSetting = $phase->next() ) {
		my $value = runAmplifierFeedbackLoop($program, @phaseSetting);
		$maxValue = $value if($value > $maxValue);
	}
	return $maxValue;
}

sub part2 {
	my ($program) = @_;
	return findHighestFeedbackLoopThrusterSignal($program);
}

1;
