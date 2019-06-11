use strict;
use warnings;

my $input = 329;
my $end = 2017;

my $zeroPosition = 0;
my $count = 0;
my $valueAfterZero;
my $pointerPosition = 0;

my $startingTime = time();

while($count <= 50000000){
	++$count;
	$pointerPosition += $input;
	$pointerPosition %= $count;
	if($pointerPosition < $zeroPosition){
		$zeroPosition++;
	}else{
		if($zeroPosition == $pointerPosition){
			$valueAfterZero = $count;
		}
	}
	++$pointerPosition;
}

print "finished after " . (time()-$startingTime) . "\n";
print $valueAfterZero;