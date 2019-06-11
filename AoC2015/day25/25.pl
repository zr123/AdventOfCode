use strict;
use warnings;
use Math::BigInt;

my $STARTING_VALUE = 20151125;
my $MULTIPLICATOR = 252533;
my $MODULATOR = 33554393;
my $INPUT_COL = 3010;
my $INPUT_ROW = 3019; 

sub getSheetCode{
	my ($col, $row) = @_;
	my $sum = 0;
	for(my $i = 1; $i <= $row; ++$i){
		$sum += $i;
	}
	for(my $i = 1; $i < $col; ++$i){
		$sum += $row;
		$row++;
	}
	return $sum;
}

my $result = Math::BigInt->new($MULTIPLICATOR);
$result->bmodpow(getSheetCode($INPUT_COL, $INPUT_ROW) -1,$MODULATOR);

print (($result * $STARTING_VALUE) % $MODULATOR);