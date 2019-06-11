use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my %input;
while(my $var = <$HANDLE>){
	$var =~ /^(\d+) <-> (.*$)/;
	$input{$1} = $2;
}
close $HANDLE;

my $groupcount = 0;

while(scalar(%input)){
	++$groupcount;
	my @k = keys(%input);
	my @location = ($k[0]);
	while(@location){
	my $currentLocation = pop(@location);
	if(exists($input{$currentLocation})){
		while($input{$currentLocation} =~ /(\d+)/g){
			push(@location, $1);
		}
		delete($input{$currentLocation});
	}
}
}

print $groupcount;