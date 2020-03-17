package Day06;
use strict;
use warnings;
use List::Util qw(sum);


sub getHashedOrbitMap {
	my @map = @_;
	my %orbitsmap;
	foreach my $orbit (@map){
		$orbit =~ /^(.+)\)(.+)$/;
		push(@{$orbitsmap{$1}}, $2);
	}
	return %orbitsmap;
}

sub getOrbitCounts {
	my %orbitsmap = @_;
	my %orbitCounts = ("COM" => 0);
	my @toEvaluate = ("COM");
	while(my $location = shift(@toEvaluate)){
		print "$location \n";
		if(exists($orbitsmap{$location})){
			my @orbitees = @{$orbitsmap{$location}};
			push(@toEvaluate, @orbitees);
			for (@orbitees){
				$orbitCounts{$_} = $orbitCounts{$location} + 1
			}
		}
	}
	return %orbitCounts;
}

sub part1 {
	my @map = @_;
	my %orbitsmap = getHashedOrbitMap(@map);
	my %orbitCounts = getOrbitCounts(%orbitsmap);
	return sum(values(%orbitCounts));
}

1;