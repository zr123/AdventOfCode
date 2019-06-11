use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $currentLine = 0;
my $stepCount = 0;

while($currentLine >= 0 && $currentLine < @input){
	if($input[$currentLine] >= 3){
		$currentLine += $input[$currentLine]--;
	}else{
		$currentLine += $input[$currentLine]++;
	}
	$stepCount++;
}

print $stepCount;