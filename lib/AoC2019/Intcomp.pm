package Intcomp;
use strict;
use warnings;

sub decode {
	my ($string) = @_;
	my @numbers = split(",", $string);
	return \@numbers;
}

sub getParam{
	my ($state, $pos_offset, $mode) = @_;
	my $position = $state->{pos} + $pos_offset;
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
	my ($state, $pos_offset, $value) = @_;
	my $position = $state->{pos} + $pos_offset;
	my $loc = $state->{instructions}[$position];
	$state->{instructions}[$loc] = $value;
}

sub op01 { # addition
	my ($state, $mode1, $mode2) = @_;
	my $value = getParam($state, +1, $mode1) + getParam($state, +2, $mode2);
	writePos($state, +3, $value);
	$state->{pos} += 4;
	return 1;
}

sub op02 { # multiplication
	my ($state, $mode1, $mode2) = @_;
	my $value = getParam($state, +1, $mode1) * getParam($state, +2, $mode2);
	writePos($state, +3, $value);
	$state->{pos} += 4;
	return 2;
}

sub op03 { # input
	my ($state) = @_;
	writePos($state, +1, $state->{input});
	$state->{pos} += 2;
	return 2;
}

sub op04 { # output
	my ($state, $mode1) = @_;
	$state->{output} = getParam($state, +1, $mode1);
	$state->{pos} += 2;
	return 2;
}

sub op05 { # jump-if-true
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) != 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
}

sub op06 { # jump-if-false
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) == 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
}

sub op07 { # less than
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) < getParam($state, +2, $mode2)){
		writePos($state, +3, 1);
	}else{
		writePos($state, +3, 0);
	}
	$state->{pos} += 4;
}

sub op08 { # equals
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) == getParam($state, +2, $mode2)){
		writePos($state, +3, 1);
	}else{
		writePos($state, +3, 0);
	}
	$state->{pos} += 4;
}

sub op99{ #exit
	return 99;
}

sub decodeOpcode {
	my ($state) = @_;
	my $currentOpcode = $state->{instructions}[$state->{pos}];
	$currentOpcode += 100000;
	$currentOpcode =~ /^1(\d)(\d)(\d)(\d\d)$/;
	return ($4, $3, $2, $1);
}

sub processOpcode {
	my ($state) = @_;
 	my ($opcode, @modes) = decodeOpcode($state);
 	my $op = "op$opcode" . '($state, @modes)';
 	return eval($op); # dont judge me
}

sub runInstructions {
    my ($instriction_string, $id) = @_;
    $id = 0 if(!defined($id));
    my %state = (pos => 0, input => $id);
    $state{instructions} = decode($instriction_string);
    while(processOpcode(\%state) != 99){}
    return %state;
}

1;