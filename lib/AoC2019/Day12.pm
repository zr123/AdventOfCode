package Day12;
use strict;
use warnings;


sub loadScan {
	my (@positions) = @_;
	my @moons = ();
	foreach my $position (@positions){
		$position =~ /<x=(-?\d+), y=(-?\d+), z=(-?\d+)>/;
		push(@moons,
			{"x" => $1, "y" => $2, "z" => $3, "x_vel" => 0, "y_vel" => 0, "z_vel" => 0});
	}
	return @moons;
}	

sub sumulateTimeStep {
	my @moons = @_;
	# calc new velocities
	for(my $i = 0; $i < @moons; ++$i){
		for(my $j = 0; $j < @moons; ++$j){
			$moons[$i]{x_vel}-- if($moons[$i]{"x"} > $moons[$j]{"x"});
			$moons[$i]{x_vel}++ if($moons[$i]{"x"} < $moons[$j]{"x"});
			$moons[$i]{y_vel}-- if($moons[$i]{"y"} > $moons[$j]{"y"});
			$moons[$i]{y_vel}++ if($moons[$i]{"y"} < $moons[$j]{"y"});
			$moons[$i]{z_vel}-- if($moons[$i]{"z"} > $moons[$j]{"z"});
			$moons[$i]{z_vel}++ if($moons[$i]{"z"} < $moons[$j]{"z"});
		}
	}
	# calc new positions
	for(my $i = 0; $i < @moons; ++$i){
		$moons[$i]{"x"} += $moons[$i]{x_vel};
		$moons[$i]{"y"} += $moons[$i]{y_vel};
		$moons[$i]{"z"} += $moons[$i]{z_vel};
	}
	return @moons;
}

sub calcEnergy {
	my @moons = @_;
	my $energy = 0;
	for my $moon (@moons){
		$energy += (abs($moon->{x}) + abs($moon->{y}) + abs($moon->{z})) * (abs($moon->{x_vel}) + abs($moon->{y_vel}) + abs($moon->{z_vel}));
	}
	return $energy;
}

sub getEnergyAfterXTimesSteps {
	my ($X, @positions) = @_;
	my @moons = loadScan(@positions);
	@moons = sumulateTimeStep(@moons) for (1..$X);
	return calcEnergy(@moons);
}

sub part1 {
	my (@input) = @_;
	return getEnergyAfterXTimesSteps(1000, @input);
}

1;