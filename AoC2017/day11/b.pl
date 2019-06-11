use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $input;

my @direction = (0, 0, 0); # (x, y, z) = (n-s, ne-sw, se-nw)
my $maxDistance = 0;
for my $dir (split(",", $input)){
	$direction[0]++ if($dir eq "n");
	$direction[0]-- if($dir eq "s");
	$direction[1]++ if($dir eq "sw");
	$direction[1]-- if($dir eq "ne");
	$direction[2]++ if($dir eq "se");
	$direction[2]-- if($dir eq "nw");
	if(calcMinumumDistance(@direction) > $maxDistance){
		$maxDistance = calcMinumumDistance(@direction);
	}
}

print $maxDistance;



sub calcMinumumDistance {
	my ($x, $y, $z) = @_;
	# direction-values can be modified according to (x+n, y+n, z+n) with any integer n (negative values also)
	# so there are 3 minimation scenarios
	my $minimum = abs($y-$x) + abs($z-$x);
	my $tmp = abs($x-$y) + abs($z-$y);
	if($tmp < $minimum){$minimum = $tmp;}
	$tmp = abs($x-$z) + abs($y-$z);
	if($tmp < $minimum){$minimum = $tmp;}

	return $minimum;
}