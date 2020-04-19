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
	%state = Intcomp::runInstructions($program, ($B, $state{output}[0]));
	%state = Intcomp::runInstructions($program, ($C, $state{output}[0]));
	%state = Intcomp::runInstructions($program, ($D, $state{output}[0]));
	%state = Intcomp::runInstructions($program, ($E, $state{output}[0]));
	return $state{output}[0];
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
	my %ampB = Intcomp::runInstructions($program, ($B, $ampA{output}[0]));
	my %ampC = Intcomp::runInstructions($program, ($C, $ampB{output}[0]));
	my %ampD = Intcomp::runInstructions($program, ($D, $ampC{output}[0]));
	my %ampE = Intcomp::runInstructions($program, ($E, $ampD{output}[0]));

	while($ampA{exitstate} ne "exit" || $ampB{exitstate} ne "exit" || $ampC{exitstate} ne "exit" || $ampD{exitstate} ne "exit" || $ampE{exitstate} ne "exit"){
		Intcomp::continueExecution(\%ampA, $ampE{output}[-1]);
		Intcomp::continueExecution(\%ampB, $ampA{output}[-1]);
		Intcomp::continueExecution(\%ampC, $ampB{output}[-1]);
		Intcomp::continueExecution(\%ampD, $ampC{output}[-1]);
		Intcomp::continueExecution(\%ampE, $ampD{output}[-1]);
	}
	return $ampE{output}[-1];
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
