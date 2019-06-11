use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my %input;
while(my $var = <$HANDLE>){
	$var =~ /^(\d+) <-> (.*$)/;
	$input{$1} = $2;
}
close $HANDLE;

my $count = 0;
my @location = ("0");

while(@location){
	my $currentLocation = pop(@location);
	if(exists($input{$currentLocation})){
		while($input{$currentLocation} =~ /(\d+)/g){
			push(@location, $1);
		}
		delete($input{$currentLocation});
		++$count;
	}
}

print $count;