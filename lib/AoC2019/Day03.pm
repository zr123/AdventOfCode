package Day03;
use strict;
use warnings;
use List::Util "min";


sub handleInstruction {
	my ($mapref, $instruction, $wiringNumber) = @_;
	$instruction =~ /^(\D)(\d+)$/;
	my $x = $mapref->{"x"};
	my $y = $mapref->{"y"};
	if($1 eq "R"){
		$mapref->{($x+$_) . " $y"} |= $wiringNumber for(1 .. $2);
		$mapref->{"x"} += $2;
	}
	if($1 eq "L"){
		$mapref->{($x-$_) . " $y"} |= $wiringNumber for(1 .. $2);
		$mapref->{"x"} -= $2;
	}
	if($1 eq "U"){
		$mapref->{"$x " . ($y+$_)} |= $wiringNumber for(1 .. $2);
		$mapref->{"y"} += $2;
	}
	if($1 eq "D"){
		$mapref->{"$x " . ($y-$_)} |= $wiringNumber for(1 .. $2);
		$mapref->{"y"} -= $2;
	}
}

sub createWiring {
	my ($instructionsString1, $instructionsString2) = @_;
	my %map = ("x" => 0, "y" => 0);
	for my $instruction (split(",", $instructionsString1)){
		handleInstruction(\%map, $instruction, 1);
	}
	$map{"x"} = $map{"y"} = 0;
	for my $instruction (split(",", $instructionsString2)){
		handleInstruction(\%map, $instruction, 2);
	}
	return \%map;
}

sub manhattenDistance {
	my ($term) = @_;
	$term =~ /^(-?\d+) (-?\d+)$/;
	return abs($1) + abs($2);
}

sub getIntersections {
	my ($mapref) = @_;
	my @intersections;
	while(my ($k, $v) = each(%{$mapref})){
		push(@intersections, $k) if($v == 3 && $k ne "x" && $k ne "y");
	}
	return @intersections;
}

sub part1 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	my @intersections = getIntersections($mapref);
	my @distances;
	push(@distances, manhattenDistance($_)) for @intersections;
	return min(@distances);
}


sub part2 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	my @intersections = getIntersections($mapref);
}

1;
