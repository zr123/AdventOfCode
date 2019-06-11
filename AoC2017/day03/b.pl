use strict;
#use warnings;

my $input = 312051; 

my %coord;
$coord{"0,0"} = 1;

my $max = 1;
my $input = 312051;

while(1){
	for(my $y = -$max +1; $y <= $max; ++$y){
		$coord{"$max,$y"} = calcValue($max, $y, %coord);
		if($coord{"$max,$y"} > $input){
			print $coord{"$max,$y"};
			goto SUCCESS;
		}
	}
	for(my $x = $max -1; $x >= -$max; --$x){
		$coord{"$x,$max"} = calcValue($x, $max, %coord);
		if($coord{"$x,$max"} > $input){
			print $coord{"$x,$max"};
			goto SUCCESS;
		}
	}
	for(my $y = $max -1; $y >= -$max; --$y){
		$coord{"-$max,$y"} = calcValue(-$max, $y, %coord);
		if($coord{"-$max,$y"} > $input){
			print $coord{"-$max,$y"};
			goto SUCCESS;
		}
	}
	for(my $x = -$max +1; $x <= $max; ++$x){
		$coord{"$x,-$max"} = calcValue($x, -$max, %coord);
		if($coord{"$x,-$max"} > $input){
			print $coord{"$x,-$max"};
			goto SUCCESS;
		}
	}
	++$max;
}

SUCCESS:

sub calcValue(){
	my ($x, $y, %coord) = @_;
	#print "<funk $x, $y>:  r" . $coord{($x+1).",".$y} . " " . "ro" . $coord{($x+1).",".($y+1)} . " " . "ru" . $coord{($x+1).",".($y-1)} . " " . "o" . $coord{$x.",".($y+1)} . " " . "u" . $coord{$x.",".($y-1)} . " " . "l" . $coord{($x-1).",".$y} . " " . "lo" . $coord{($x-1).",".($y+1)} . " " . "lu" . $coord{($x-1).",".($y-1)} . "\n";
	return 	$coord{($x+1).",".$y} + 
			$coord{($x+1).",".($y+1)} + 
			$coord{($x+1).",".($y-1)} + 
			$coord{$x.",".($y+1)} + 
			$coord{$x.",".($y-1)} + 
			$coord{($x-1).",".$y} + 
			$coord{($x-1).",".($y+1)} + 
			$coord{($x-1).",".($y-1)};
}