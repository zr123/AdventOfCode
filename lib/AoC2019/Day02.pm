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
    my ($instriction_string) = @_;
	my @instructions = decode($instriction_string);
	my $pointer = 0;
	while(1){
		last if(processOpcode($pointer, \@instructions ) == 99);
		$pointer += 4;
	}
	return encode(@instructions)
}

sub run_with {
	my ($noun, $verb, $instriction_string) = @_;
	$instriction_string =~ s/^(\d+),\d+,\d+/$1,$noun,$verb/;
	print($instriction_string);
	$instriction_string = runInstructions($instriction_string);
	my @instructions = decode($instriction_string);
	return $instructions[0];
}

sub part1 {
	my ($instriction_string) = @_;
	my @instructions = decode($instriction_string);
	return run_with(12, 2, $instriction_string);
}

#run_with(12, 2, "1,9,10,3,2,3,11,0,99,30,40,50");


1;
