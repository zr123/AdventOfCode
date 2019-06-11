use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $sum = 0;

foreach my $line (@input){
	my @numbers = split("\t", $line);
	@numbers = sort{$a <=> $b}(@numbers);
	$sum += $numbers[-1] - $numbers[0];
}

print "$sum\n";