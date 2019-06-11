use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

my @banks = split("\t", $input);
my %states;
my $cycles = 0;

while(1){
	if($states{join(";", @banks)}++ > 0){
		last;
	}
	my $pos  = maxPos(@banks);
	my $value = $banks[$pos];
	$banks[$pos] = 0;
	$pos++;
	if($pos >= @banks){
		$pos = 0;
	}
	while($value > 0){
		$banks[$pos]++;
		$value--;
		$pos++;
		if($pos >= @banks){
			$pos = 0;
		}
	}
	$cycles++;
}

print $cycles;




sub maxPos{
	my (@list) = @_;
	my $max = 0;
	my $maxPos = 0;
	for(my $i = 0; $i < @list; $i++){
		if($list[$i] > $max){
			$max = $list[$i];
			$maxPos = $i;
		}
	}
	return $maxPos;
}