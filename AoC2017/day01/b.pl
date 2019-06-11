use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

my $sum = 0;
my @digits = split("", $input);
my $count = scalar(@digits)/2;

for(my $i = 0; $i < $count; ++$i){
	
	if($digits[$i] eq $digits[$i + $count]){
		$sum += $digits[$i];
	}
}


print $sum*2 . "\n";