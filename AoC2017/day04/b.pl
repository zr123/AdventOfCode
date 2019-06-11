use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $sumTotal = 0;
foreach my $line (@input){
	if(checkLineForAnagrams($line)){
		$sumTotal++;
	}
}
	
print $sumTotal;





sub checkLineForAnagrams{
	my ($line) = @_;
	my @words = split(" ", $line);
	my %resulthash;
	for(my $i = 0; $i < @words; $i++){
		my @charArray = split("", $words[$i]);
		@charArray = sort {$a cmp $b} @charArray;
		my $sortedword = join("", @charArray);
		$resulthash{$sortedword}++;
		if($resulthash{$sortedword} > 1){
			return 0;
		}
	}
	
	return 1;
}