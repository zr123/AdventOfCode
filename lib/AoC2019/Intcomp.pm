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

my @opcodes;

$opcodes[1] = sub { # addition
	my ($state, $mode1, $mode2) = @_;
	my $value = getParam($state, +1, $mode1) + getParam($state, +2, $mode2);
	writePos($state, +3, $value);
	$state->{pos} += 4;
	return 1;
};

$opcodes[2] = sub { # multiplication
	my ($state, $mode1, $mode2) = @_;
	my $value = getParam($state, +1, $mode1) * getParam($state, +2, $mode2);
	writePos($state, +3, $value);
	$state->{pos} += 4;
	return 2;
};

$opcodes[3] = sub { # input
	my ($state) = @_;
	writePos($state, +1, $state->{input});
	$state->{pos} += 2;
	return 2;
};

$opcodes[4] = sub { # output
	my ($state, $mode1) = @_;
	$state->{output} = getParam($state, +1, $mode1);
	$state->{pos} += 2;
	return 2;
};

$opcodes[5] = sub { # jump-if-true
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) != 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
};

$opcodes[6] = sub { # jump-if-false
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) == 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
};

$opcodes[7] = sub { # less than
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) < getParam($state, +2, $mode2)){
		writePos($state, +3, 1);
	}else{
		writePos($state, +3, 0);
	}
	$state->{pos} += 4;
};

$opcodes[8] = sub { # equals
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) == getParam($state, +2, $mode2)){
		writePos($state, +3, 1);
	}else{
		writePos($state, +3, 0);
	}
	$state->{pos} += 4;
};

$opcodes[99] = sub { #exit
	return 99;
};

sub decodeOpcode {
	my ($currentOpcode) = @_;
	$currentOpcode += 100000;
	$currentOpcode =~ /^1(\d)(\d)(\d)(\d\d)$/;
	return ($4, $3, $2, $1);
}

sub getCurrentOpcode {
	my ($state) = @_;
	return $state->{instructions}[$state->{pos}]
}

sub processOpcode {
	my ($state) = @_;
 	my ($opcode, @modes) = decodeOpcode(getCurrentOpcode($state));
 	return $opcodes[$opcode]($state, @modes);
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