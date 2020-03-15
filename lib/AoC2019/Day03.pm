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

sub checkWiring {
	my ($path, $value, $wiringNumber, $mapref) = @_;
	return 0 if(!defined($mapref->{$path}));	 			# no wiring
	return 0 unless($mapref->{$path} & $wiringNumber);	# wrong wiring
	return 0 if (defined($mapref->{"$path PATHVALUE$wiringNumber"}) && ($mapref->{"$path PATHVALUE$wiringNumber"} <= $value));	# better path exists
	return 1;
}

sub setAdjacentFieldPathValue {
	my ($path, $wiringNumber, $mapref) = @_;
	$path =~ /^(-?\d+) (-?\d+)$/;
	my ($x, $y) = ($1, $2);
	my @nextPaths;
	
	my ($p, $v) = (($x+1) . " $y", $mapref->{"$path PATHVALUE$wiringNumber"} +1);
	if(checkWiring($p, $v, $wiringNumber, $mapref)){
		$mapref->{"$p PATHVALUE$wiringNumber"} = $v;
		push(@nextPaths, $p);
	}
	
	($p, $v) = (($x-1) . " $y", $mapref->{"$path PATHVALUE$wiringNumber"} +1);
	if(checkWiring($p, $v, $wiringNumber, $mapref)){
		$mapref->{"$p PATHVALUE$wiringNumber"} = $v;
		push(@nextPaths, $p);
	}
	
	($p, $v) = ("$x " . ($y+1), $mapref->{"$path PATHVALUE$wiringNumber"} +1);
	if(checkWiring($p, $v, $wiringNumber, $mapref)){
		$mapref->{"$p PATHVALUE$wiringNumber"} = $v;
		push(@nextPaths, $p);
	}
	
	($p, $v) = ("$x " . ($y-1), $mapref->{"$path PATHVALUE$wiringNumber"} +1);
	if(checkWiring($p, $v, $wiringNumber, $mapref)){
		$mapref->{"$p PATHVALUE$wiringNumber"} = $v;
		push(@nextPaths, $p);
	}

	return @nextPaths;
}

sub addPathValues {
	my ($wiringNumber, $mapref) = @_;
	
	$mapref->{"0 0 PATHVALUE$wiringNumber"} = 0;
	my @paths = setAdjacentFieldPathValue("0 0", $wiringNumber, $mapref);
	while(my $path = pop(@paths)){
		push(@paths, setAdjacentFieldPathValue($path, $wiringNumber, $mapref));
	}
}

sub part2 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	addPathValues(1, $mapref);
	addPathValues(2, $mapref);
	my @intersections = getIntersections($mapref);
	my @pathValues;
	for (@intersections){
		if($_ =~ /^(\d+) (\d+)$/){
			push(@pathValues, $mapref->{"$1 $2 PATHVALUE1"} + $mapref->{"$1 $2 PATHVALUE2"});
		}
	}
	return min(@pathValues);
}

1;
