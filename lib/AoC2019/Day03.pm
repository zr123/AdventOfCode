package Day03;
use strict;
#use warnings;
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

sub pathDistance {
	my ($key, $mapref) = @_;
}


sub checkWiring {
	my ($x, $y, $wiringNumber, $mapref) = @_;
	if(defined($mapref->{"$x $y"}) && ($mapref->{"$x $y"} & $wiringNumber)){
		return 1;
	}
	return 0;
}


sub addPathValues {
	my ($x, $y, $value, $wiringNumber, $mapref) = @_;
	
	if(defined($mapref->{"$x $y PATHVALUE$wiringNumber"}) && $mapref->{"$x $y PATHVALUE$wiringNumber"} < $value){
		return;
	}
	$mapref->{"$x $y PATHVALUE$wiringNumber"} = $value;
	
	if(checkWiring($x+1, $y, $wiringNumber, $mapref)){
		addPathValues($x+1, $y, $value+1, $wiringNumber, $mapref)
	}
	if(checkWiring($x-1, $y, $wiringNumber, $mapref)){
		addPathValues($x-1, $y, $value+1, $wiringNumber, $mapref)
	}
	if(checkWiring($x, $y+1, $wiringNumber, $mapref)){
		addPathValues($x, $y+1, $value+1, $wiringNumber, $mapref)
	}
	if(checkWiring($x, $y-1, $wiringNumber, $mapref)){
		addPathValues($x, $y-1, $value+1, $wiringNumber, $mapref)
	}
}


sub part2 {
	my ($instructionsString1, $instructionsString2) = @_;
	my $mapref = createWiring($instructionsString1, $instructionsString2);
	addPathValues(0, 0, 0, 1, $mapref);
	addPathValues(0, 0, 0, 2, $mapref);
	my @intersections = getIntersections($mapref);
	my @pathValues;
	for (@intersections){
		if($_ =~ /^(\d+) (\d+)$/){
			print "$1 $2" . $mapref->{"$1 $2 PATHVALUE1"} . " " . $mapref->{"$1 $2 PATHVALUE2"} . "\n";
			push(@pathValues, $mapref->{"$1 $2 PATHVALUE1"} + $mapref->{"$1 $2 PATHVALUE2"});
		}
	}
	#push(@pathValues, pathDistance($_)) for @intersections;
	return min(@pathValues);
}

1;
