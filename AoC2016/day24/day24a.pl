use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @field;
my $MAX_Y;
my $MAX_X;
my $row = 0;
my (@coord_x, @coord_y);

# figure shit out
for my $line (@input){
	chomp($line);
	my $col = 0;
	for my $char (split(//, $line)){
		if($char eq '#'){
			$field[$row][$col] = -10;
		}else{
			if($char eq '.'){
				$field[$row][$col] = 0;
			}else{
				$field[$row][$col] = 0;
				$coord_x[$char] = $row;
				$coord_y[$char] = $col;
			}
		}
		++$col;
	}
	$MAX_Y = $col;
	$MAX_X = ++$row;
}

# apply da algorithms
print $field[$coord_x[0]][$coord_y[0]] . "\n\n";
#for(my $x = 0; $x < $MAX_X; ++$x){
#	for(my $y = 0; $y < $MAX_Y; ++$y){

#print shit out
for(0.. (@coord_x -1)){
	print "coord $_: (" . $coord_x[$_] . ";" . $coord_y[$_] . ")\n";
}

for(my $x = 0; $x < $MAX_X; ++$x){
	for(my $y = 0; $y < $MAX_Y; ++$y){
		if($field[$x][$y] == -10){
			print "#";
		}else{
			print $field[$x][$y];
		}
	}
	print "\n";
}