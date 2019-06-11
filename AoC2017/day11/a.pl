use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $input;

my @direction = (0, 0, 0); # (x, y, z) = (n-s, sw-ne, se-nw)
$direction[0] = (() = $input =~ /\bn\b/g) - (() = $input =~ /\bs\b/g);
$direction[1] = (() = $input =~ /\bsw\b/g) - (() = $input =~ /\bne\b/g);
$direction[2] = (() = $input =~ /\bse\b/g) - (() = $input =~ /\bnw\b/g);

print calcMinumumDistance(@direction);



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