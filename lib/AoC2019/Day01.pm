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

sub getActualFuel {
	my ($mass) = @_;
	my $totalFuel = 0;
	my $fuel = getFuel($mass);
	while($fuel > 0){
		print "$fuel\n";
		$totalFuel += $fuel;
		$fuel = getFuel($fuel);		
	}
	return $totalFuel;
}

sub part2 {
    my @modules = @_;
	my $sum = 0;
	print @modules;
	for(@modules) {
		$sum += getActualFuel($_);
	}
	return $sum;
}

1;
