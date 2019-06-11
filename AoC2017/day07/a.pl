use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my %programs;

for my $line (@input){
	while($line =~ /\b([a-zA-Z]+)\b/g){
		$programs{$1}++;
	}
}

while(my ($program, $timesUsed) = each(%programs)){
	if($timesUsed == 1){
		print "$program";
		last;
	}
}