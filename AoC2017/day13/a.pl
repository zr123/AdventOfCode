use strict;
#use warnings;

open my $HANDLE, "<", "input.txt";
my @depth;
while(my $line = <$HANDLE>){
	$line =~ /^(\d+): (\d+)$/;
	$depth[$1] = $2;
}
close $HANDLE;

my @scannerLocation;
my @scannerDirection;
for(my $i = 0; $i < @depth; ++$i){
	$scannerLocation[$i] = 1;
	$scannerDirection[$i] = 1;
}


my $severity = 0;
for(my $location = 0; $location < @depth; ++$location){
	if($scannerLocation[$location] == 1){
		$severity += $location * $depth[$location];
	}

	#move scanners
	for(my $i = 0; $i < @depth; ++$i){
		$scannerLocation[$i] += $scannerDirection[$i];
		if($scannerLocation[$i] == 1 || $scannerLocation[$i] == $depth[$i]){
			$scannerDirection[$i] *= -1;
		}
	}
}

print $severity;