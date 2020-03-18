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


sub getOrbitPath {
	my ($location, @map) = @_;
	my %reverseorbitsmap;
	foreach my $orbit (@map){
		$orbit =~ /^(.+)\)(.+)$/;
		$reverseorbitsmap{$2} = $1;
	}
	my $orbitPath = $location;
	while($location ne "COM"){
		$orbitPath = $reverseorbitsmap{$location} . ")" . $orbitPath;
		$location = $reverseorbitsmap{$location};
	}
	return $orbitPath;
}

sub findFirstCommonPlanet {
	my ($loc1, $loc2) = @_;
	for (reverse(split(/\)/, $loc1))){
		if($loc2 =~ /\)$_\)/){
			return $_;
		}
	}
}

sub part2 {
	my @map = @_;
	my %orbitsmap = getHashedOrbitMap(@map);
	my %orbitCounts = getOrbitCounts(%orbitsmap);
	my ($youloc, $sanloc) = (getOrbitPath("YOU", @map), getOrbitPath("SAN", @map));
	my $commonPlanet = findFirstCommonPlanet($youloc, $sanloc);
	return $orbitCounts{"YOU"} + $orbitCounts{"SAN"} -2*$orbitCounts{$commonPlanet} -2
}

1;