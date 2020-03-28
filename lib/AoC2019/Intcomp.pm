package Intcomp;
use strict;
use warnings;

sub decode {
	my ($string) = @_;
	my @numbers = split(",", $string);
	return \@numbers;
}

sub op1_addition {
	my ($state) = @_;
	my ($arg1, $arg2, $arg3) = @{$state->{instructions}}[$state->{pos}+1 .. $state->{pos}+3];
	$state->{instructions}[$arg3] = $state->{instructions}[$arg1] + $state->{instructions}[$arg2];
	$state->{pos} += 4;
	return 1;
}

sub op2_multiplication {
	my ($state) = @_;
	my ($arg1, $arg2, $arg3) = @{$state->{instructions}}[$state->{pos}+1 .. $state->{pos}+3];
	$state->{instructions}[$arg3] = $state->{instructions}[$arg1] * $state->{instructions}[$arg2];
	$state->{pos} += 4;
	return 2;
}

sub processOpcode {
	my ($state) = @_;
	my $currentOpcode = $state->{instructions}[$state->{pos}];
	return 99 							if($currentOpcode == 99);
	return op1_addition($state) 		if($currentOpcode ==  1);
	return op2_multiplication($state) 	if($currentOpcode ==  2);
	die("Unexpected Opcode");
}

sub runInstructions {
    my ($instriction_string) = @_;
    my %state = (pos => 0);
    $state{instructions} = decode($instriction_string);
    while(processOpcode(\%state) != 99){}
    return %state;
}

1;