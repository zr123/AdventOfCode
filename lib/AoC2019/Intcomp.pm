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
	if($mode == 0){ # Position mode
		return $state->{instructions}[$valueAtPos];
	}
	if($mode == 1){ # Immediate mode
		return $valueAtPos;
	}
	if($mode == 2){ # Relative mode
		return $state->{instructions}[$valueAtPos + $state->{relativeBase}];
	}
	die("getParam: Unexpected Mode $mode: Position $position \n" + %{$state});
}

sub writePos {
	my ($state, $pos_offset, $value, $mode) = @_;
	my $position = $state->{pos} + $pos_offset;
	my $valueAtPos = $state->{instructions}[$position];
	if($mode == 0){ # Position mode
		$state->{instructions}[$valueAtPos] = $value;
		return;
	}
	if($mode == 2){ # Relative mode
		$state->{instructions}[$valueAtPos + $state->{relativeBase}] = $value;
		return;
	}
	die("writePos: Unexpected Mode $mode: Position $position \n" + %{$state});
}

my @opcodes;

$opcodes[1] = sub { # addition
	my ($state, $mode1, $mode2, $mode3) = @_;
	my $value = getParam($state, +1, $mode1) + getParam($state, +2, $mode2);
	writePos($state, +3, $value, $mode3);
	$state->{pos} += 4;
	return 1;
};

$opcodes[2] = sub { # multiplication
	my ($state, $mode1, $mode2, $mode3) = @_;
	my $value = getParam($state, +1, $mode1) * getParam($state, +2, $mode2);
	writePos($state, +3, $value, $mode3);
	$state->{pos} += 4;
	return 2;
};

$opcodes[3] = sub { # input: try to write value from input to pos
	my ($state, $mode1) = @_;
	my $value = shift(@{$state->{input}});
	if(!defined($value)){
		# halt and wait for input
		$state->{exitstate} = "halt";
		return 99;
	}
	writePos($state, +1, $value, $mode1);
	$state->{pos} += 2;
	return 3;
};

$opcodes[4] = sub { # output
	my ($state, $mode1) = @_;
	push(@{$state->{output}}, getParam($state, +1, $mode1));
	$state->{pos} += 2;
	return 4;
};

$opcodes[5] = sub { # jump-if-true
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) != 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
	return 5;
};

$opcodes[6] = sub { # jump-if-false
	my ($state, $mode1, $mode2) = @_;
	if(getParam($state, +1, $mode1) == 0){
		$state->{pos} = getParam($state, +2, $mode2);
	}else{
		$state->{pos} += 3;
	}
	return 6;
};

$opcodes[7] = sub { # less than
	my ($state, $mode1, $mode2, $mode3) = @_;
	if(getParam($state, +1, $mode1) < getParam($state, +2, $mode2)){
		writePos($state, +3, 1, $mode3);
	}else{
		writePos($state, +3, 0, $mode3);
	}
	$state->{pos} += 4;
	return 7;
};

$opcodes[8] = sub { # equals
	my ($state, $mode1, $mode2, $mode3) = @_;
	if(getParam($state, +1, $mode1) == getParam($state, +2, $mode2)){
		writePos($state, +3, 1, $mode3);
	}else{
		writePos($state, +3, 0, $mode3);
	}
	$state->{pos} += 4;
	return 8;
};

$opcodes[9] = sub { # relative base adjustment
	my ($state, $mode1) = @_;
	$state->{relativeBase} += getParam($state, +1, $mode1);
	$state->{pos} += 2;
	return 9;
};

$opcodes[99] = sub { #exit
	my ($state) = @_;
	$state->{exitstate} = "exit";
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
    my ($instriction_string, @input) = @_;
    my %state = (pos => 0, relativeBase => 0, input => \@input);
    $state{instructions} = decode($instriction_string);
    while(processOpcode(\%state) != 99){}
    return %state;
}

sub continueExecution {
	my ($stateRef, @input) = @_;
	$stateRef->{input} = \@input;
	while(processOpcode($stateRef) != 99){}
	return $stateRef;
}

1;