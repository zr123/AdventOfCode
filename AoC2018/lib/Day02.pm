package Day02;
use strict;
use warnings;

sub twice {
	my ($id) = @_;
	my %charcount;
	for my $char (split('', $id)){
		$charcount{$char}++;
	}
	for my $value (values(%charcount)){
		if($value == 2){
			return 1;
		}
	}
	return 0;
}

sub thrice {
	my ($id) = @_;
	my %charcount;
	for my $char (split('', $id)){
		$charcount{$char}++;
	}
	for my $value (values(%charcount)){
		if($value == 3){
			return 1;
		}
	}
	return 0;
}

sub part1 {
	my (@boxIDs) = @_;
	my ($twices, $thrices);
	for my $id (@boxIDs){
		if (twice($id)){
			$twices++;
		}
		if (thrice($id)){
			$thrices++;
		}
	}
	return $twices * $thrices;
}

sub difference {
	return 0;
}

sub part2 {
	return "weasel";
}

1;