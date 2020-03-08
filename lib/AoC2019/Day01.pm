package Day01;
use strict;
use warnings;

sub getFuel {
	my ($mass) = @_;
	return int($mass / 3) - 2;
}

sub part1 {
    my @modules = @_;
	my $sum = 0;
	print @modules;
	for(@modules) {
		$sum += getFuel($_);
	}
	return $sum;
}

1;
