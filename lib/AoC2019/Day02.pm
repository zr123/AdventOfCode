package Day02;
use strict;
use warnings;

sub decode {
	my ($string) = @_;
	my @numbers = split(",", $string);
	return @numbers;
}

sub encode {
	my @numbers = @_;
	my $string = join(",", @numbers);
	return $string;
}

sub processOpcode {
	my ($pointer, $instructions) = @_;
	if($instructions->[$pointer] == 99){
		return 99;
	}
	my $loc_term1 = $instructions->[$pointer+1];
	my $loc_term2 = $instructions->[$pointer+2];
	my $loc = $instructions->[$pointer+3] ;
	if($instructions->[$pointer] == 1){
		$instructions->[$loc] =  $instructions->[$loc_term1] + $instructions->[$loc_term2];
		return 1;
	}
	if($instructions->[$pointer] == 2){
		$instructions->[$loc] =  $instructions->[$loc_term1] * $instructions->[$loc_term2];
		return 2;
	}
}

sub runInstructions {
    my ($instruction_string) = @_;
	my @instructions = decode($instruction_string);
	my $pointer = 0;
	while(1){
		last if(processOpcode($pointer, \@instructions ) == 99);
		$pointer += 4;
	}
	return @instructions;
}

sub runWith {
	my ($noun, $verb, $instruction_string) = @_;
	$instruction_string =~ s/^(\d+),\d+,\d+/$1,$noun,$verb/;
	my @instructions = runInstructions($instruction_string);
	return $instructions[0];
}

sub part1 {
	my ($instruction_string) = @_;
	my @instructions = decode($instruction_string);
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
