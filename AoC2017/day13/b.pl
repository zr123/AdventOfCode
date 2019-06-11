use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @scannerLocation;
my @scannerDepth;
while(my $line = <$HANDLE>){
	$line =~ /^(\d+): (\d+)$/;
	push(@scannerLocation, $1);
	push(@scannerDepth, $2);
}
close $HANDLE;

my $delay = 0;

my $detected = 1;
while($detected){
	$detected = 0;
	for(my $i = 0; $i < @scannerLocation; ++$i){
		if(($delay + $scannerLocation[$i]) % (2*($scannerDepth[$i]-1)) == 0){
			$detected = 1;
			last;
		}
	}
	$delay++;
}

print ($delay-1);