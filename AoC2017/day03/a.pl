use strict;
use warnings;

# buggy für Quadratzahlen. Ergebniss ist 2 zu hoch
my $input = 312051; 

my $root = int(sqrt($input));
if($root%2 == 0){$root--;}

my $baseValue = $root+1;

my $sqare = ($root+2)**2;
while($sqare > $input+$root){
	$sqare -= ($root+1);
}

my $modifier = ($sqare-$input);
if($modifier > ($root+1)/2){
	$modifier = ($root+1) - $modifier;
}
print $baseValue - $modifier;