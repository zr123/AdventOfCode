package Intcomp;
use strict;
use warnings;

sub decode {
	my ($string) = @_;
	my @numbers = split(",", $string);
	return \@numbers;
}

sub getParam{
	my ($state, $position, $mode) = @_;
	my $valueAtPos = $state->{instructions}[$position];
	if($mode == 0){ # Parameter mode
		return $state->{instructions}[$valueAtPos]
	}
	if($mode == 1){ # Immediate mode
		return $valueAtPos;
	}
	die("Unexpected Mode $mode: Position $position \n" + %{$state});
}

sub writePos {
	my ($state, $position, $value) = @_;
	my $loc = $state->{instructions}[$position];
	$state->{instructions}[$loc] = $value;
}

sub op1_addition {
	my ($state, $mode1, $mode2) = @_;
	my $pos = $state->{pos};
	my $value = getParam($state, $pos+1, $mode1) + getParam($state, $pos+2, $mode2);
	writePos($state, $pos+3, $value);
	$state->{pos} += 4;
	return 1;
}

sub op2_multiplication {
	my ($state, $mode1, $mode2) = @_;
	my $pos = $state->{pos};
	my $value = getParam($state, $pos+1, $mode1) * getParam($state, $pos+2, $mode2);
	writePos($state, $pos+3, $value);
	$state->{pos} += 4;
	return 2;
}

sub op3_input {
	my ($state) = @_;
	my $pos = $state->{pos};
	writePos($state, $pos+1, $state->{input});
	$state->{pos} += 2;
	return 2;
}

sub op4_output {
	my ($state) = @_;
	my $pos = $state->{pos};
	$state->{output} = getParam($state, $pos+1, 0);
	$state->{pos} += 2;
	return 2;
}

sub weasel {
	my ($state) = @_;
	my $currentOpcode = $state->{instructions}[$state->{pos}];
	$currentOpcode += 100000;
	$currentOpcode =~ /^1(\d)(\d)(\d)(\d\d)$/;
	return ($4, $3, $2, $1);
}

sub processOpcode {
	my ($state) = @_;
 	my ($opcode, @modes) = weasel($state);
	return 99 									if($opcode == 99);
	return op1_addition($state, @modes) 		if($opcode ==  1);
	return op2_multiplication($state, @modes)	if($opcode ==  2);
	return op3_input($state, @modes) 			if($opcode ==  3);
	return op4_output($state, @modes)			if($opcode ==  4);
	die("Unexpected Opcode");
}

sub runInstructions {
    my ($instriction_string) = @_;
    my %state = (pos => 0, input => 1);
    $state{instructions} = decode($instriction_string);
    while(processOpcode(\%state) != 99){}
    return %state;
}

1;