use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

my $sum = 0;
while($input =~ /(\d)(?=\1)/g){	
	$sum += $1;
}

my @digits = split("", $input);
if($digits[0] eq $digits[-1]){
	$sum += $digits[0];
}

print $sum . "\n";