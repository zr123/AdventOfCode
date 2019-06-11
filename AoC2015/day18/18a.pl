use strict;
use warnings;

use List::Util qw(sum);
my ($DIM_x, $DIM_y) = (100, 100);

my @map;
open my $handle, "< 18.txt";
my $c = 0;
while(<$handle>){
  for(my $i = 0; $i < $DIM_x; ++$i){
    $map[$c][$i] = (substr($_, $i, 1) eq "#")?1:0;    
  }
  $c++;
}

sub setfield {
  my ($x, $y, @m) = @_;
  my $sum = 0;
  if($x-1 >= 0){
    if($y-1 >= 0){
      $sum += $m[$x-1][$y-1];
    }
    $sum += $m[$x-1][$y];
    if($y+1 < $DIM_y){
      $sum += $m[$x-1][$y+1];
    }
  }
  if($y-1 >= 0){
    $sum += $m[$x][$y-1];
  }
  if($y+1 < $DIM_y){
    $sum += $m[$x][$y+1];
  }
  if($x+1 < $DIM_x){
    if($y-1 >= 0){
      $sum += $m[$x+1][$y-1];
    }
    $sum += $m[$x+1][$y];
    if($y+1 < $DIM_y){
      $sum += $m[$x+1][$y+1];
    }
  }
  if($sum == 3){
    return 1;
  }
  if($sum == 2){
    return $m[$x][$y];
  }
  return 0;
}

sub weasel {
  my @m;
  for my $x (0 .. $DIM_x-1){
    for my $y (0 .. $DIM_y-1){
      $m[$x][$y] = setfield($x, $y, @_);
    }
  }
  return @m;
}

for my $i (0 .. 99){
  @map = weasel(@map);
}

my $sum = 0;
for my $line (@map){
  $sum += sum(@$line);
}
print "$sum\n";