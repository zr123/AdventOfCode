package Day03;
use strict;
use warnings;
use List::Util "min";


sub setField {
	my ($mapref, $x, $y, $wiringNumber, $value) = @_;
	$mapref->{"$x $y"} |= $wiringNumber;
	if(!exists($mapref->{"$x $y PATHVALUE$wiringNumber"})){
		$mapref->{"$x $y PATHVALUE$wiringNumber"} = $value;
	}
}

sub handleInstruction {
	my ($mapref, $instruction, $currentPathValue, $wiringNumber) = @_;
	$instruction =~ /^(\D)(\d+)$/;
	my $x = $mapref->{"x"};
	my $y = $mapref->{"y"};
	if($1 eq "R"){
		setField($mapref, $x + $_, $y, $wiringNumber, ++$currentPathValue) for(1 .. $2);
		$mapref->{"x"} += $2;
	}
	if($1 eq "L"){
		setField($mapref, $x - $_, $y, $wiringNumber, ++$currentPathValue) for(1 .. $2);
		$mapref->{($x-$_) . " $y"} |= $wiringNumber for(1 .. $2);
		$mapref->{"x"} -= $2;
	}
	if($1 eq "U"){
		setField($mapref, $x, $y + $_, $wiringNumber, ++$currentPathValue) for(1 .. $2);
		$mapref->{"y"} += $2;
	}
	if($1 eq "D"){
		setField($mapref, $x, $y - $_, $wiringNumber, ++$currentPathValue) for(1 .. $2);
		$mapref->{"y"} -= $2;
	}
	return $2;
}

sub createWiring {
	my ($instructionsString1, $instructionsString2) = @_;
	my %map = ("x" => 0, "y" => 0);
	my $currentPathValue = 0;
	for my $instruction (split(",", $instructionsString1)){
		$currentPathValue += handleInstruction(\%map, $instruction, $currentPathValue, 1);
	}
	$map{"x"} = $map{"y"} = $currentPathValue = 0;
	for my $instruction (split(",", $instructionsString2)){
		$currentPathValue += handleInstruction(\%map, $instruction, $currentPathValue, 2);
	}
	return \%map;
}

sub manhattanDistance {
	my ($term) = @_;
	$term =~ /^(-?\d+) (-?\d+)$/;
	return abs($1) + abs($2);
}

sub getIntersections {
	my ($mapref) = @_;
	my @intersections;
	while(my ($k, $v) = each(%{$mapref})){
		push(@intersections, $k) if($k =~ /^-?\d+ -?\d+$/ && $v == 3);
	}
	return @intersections;
}

sub part1 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	my @intersections = getIntersections($mapref);
	my @distances;
	push(@distances, manhattanDistance($_)) for @intersections;
	return min(@distances);
}

sub part2 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	my @intersections = getIntersections($mapref);
	my @pathValues;
	push(@pathValues, $mapref->{"$_ PATHVALUE1"} + $mapref->{"$_ PATHVALUE2"}) for (@intersections);
	return min(@pathValues);
}

1;
