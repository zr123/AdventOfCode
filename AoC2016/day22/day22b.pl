use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @grid;
handleInput($_) foreach <$HANDLE>;
close $HANDLE;

my $count = 0;
for(my $y = 0; $y < 28; ++$y){
  for(my $x = 0; $x < 38; ++$x){
    if($grid[$y][$x]{used} == 0){
      print "_";
    }else{
      if($grid[$y][$x]{size} <= 100){
        print ".";
      }else{
        print "#";
      }
    }
  }
  print "\n";
}

# call be lazy, but I counted rather than implementing something :D
# 23 to left to bypass "wall"
# 24 up for obvious reasons
# 24 right to reach desired data
# 5 * 36 => 5 turns to move G left, 36 times
# 1 final move
print 23+24+24+(5*36)+1 ,"\n";


sub handleInput{
  my ($line) = @_;
  if($line =~ /\/dev\/grid\/node-x(\d+)-y(\d+) +(\d+)T +(\d+)T +(\d+)T +(\d+)%/){
    $grid[$2][$1] = {
      size    =>  $3,
      used    =>  $4,
      avail   =>  $5
    };
  }
  
}