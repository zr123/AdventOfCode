use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $sum = 0;

foreach my $line (@input){
	my @numbers = split("\t", $line);
	@numbers = sort{$a <=> $b}(@numbers);
	for(my $a = 0; $a < scalar(@numbers); ++$a){
		for(my $b = $a+1; $b < scalar(@numbers); ++$b){
			if(isInteger($numbers[$b]/$numbers[$a])){
				$sum += $numbers[$b] / $numbers[$a];
				last;
			}
		}
	}

}

print "$sum \n";



sub isInteger{
	my ($number) = @_;
	if(int($number) == $number){
		return 1;
	}
	return 0;
}