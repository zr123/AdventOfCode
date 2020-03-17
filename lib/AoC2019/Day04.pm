package Day04;
use strict;
use warnings;
use 5.010;

sub checkDoubles {
	my ($number) = @_;
	if($number =~ /(\d)\1/){
		return 1;
	}
	return 0;
}

sub checkAscending {
	my ($number) = @_;
	my @digits = $number =~ /^(\d)(\d)(\d)(\d)(\d)(\d)$/;
	my @sortedDigits = sort(@digits);
	if(@digits ~~ @sortedDigits){
		return 1;
	}
	return 0;
}

sub checkNumber {
	my ($number) = @_;
	return checkDoubles($number) && checkAscending($number);
}

sub part1 {
	my ($low, $high) = @_;
	my $count = 0;
	for(my $i = $low; $i < $high; ++$i){
		++$count if checkNumber($i);
	}
	return $count;
}

sub checkDoublesButNotTriples {
	my ($number) = @_;
	# substitute triples, quadruples, quintuples and sextuples
	$number =~ s/(\d)\1\1+/_/g;
	if($number =~ /(\d)\1/){
		return 1;
	}
	return 0;
}

sub checkNumber2 {
	my ($number) = @_;
	return checkDoublesButNotTriples($number) && checkAscending($number);
}

sub part2 {
	my ($low, $high) = @_;
	my $count = 0;
	for(my $i = $low; $i < $high; ++$i){
		++$count if checkNumber2($i);
	}
	return $count;
}

1;
