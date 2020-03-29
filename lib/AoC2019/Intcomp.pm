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
	my $value = getParam($state, $pos+1, 0) + getParam($state, $pos+2, 0);
	writePos($state, $pos+3, $value);
	$state->{pos} += 4;
	return 1;
}

sub op2_multiplication {
	my ($state) = @_;
	my $pos = $state->{pos};
	my $value = getParam($state, $pos+1, 0) * getParam($state, $pos+2, 0);
	writePos($state, $pos+3, $value);
	$state->{pos} += 4;
	return 2;
}

sub op3_weasel {

}

sub op4_weasel {

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