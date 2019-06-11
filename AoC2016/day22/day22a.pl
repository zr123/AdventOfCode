use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @grid;
handleInput($_) foreach <$HANDLE>;
close $HANDLE;

my $count = 0;
for(my $x = 0; $x < 38; ++$x){
  for(my $y = 0; $y < 28; ++$y){
    for(my $x_i = 0; $x_i < 38; ++$x_i){
      for(my $y_i = 0; $y_i < 28; ++$y_i){
        if(!($x == $x_i && $y == $y_i) && $grid[$x][$y]{used} != 0 && $grid[$x][$y]{used} <= $grid[$x_i][$y_i]{avail}){
          $count++;
        }
      }
    }     
  }
}
print "$count\n";


sub handleInput{
  my ($line) = @_;
  if($line =~ /\/dev\/grid\/node-x(\d+)-y(\d+) +(\d+)T +(\d+)T +(\d+)T +(\d+)%/){
    $grid[$1][$2] = {
      size    =>  $3,
      used    =>  $4,
      avail   =>  $5
    };
  }
  
}