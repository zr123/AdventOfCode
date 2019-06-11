use strict;
use warnings;

my @grid;
for(my $i = 0; $i < 1000; ++$i){
  for(my $c = 0; $c < 1000; ++$c){
    $grid[$i][$c] = 0;
  }
}

sub interpret {
  my $instruction = $_[0];
  $instruction =~ /^(toggle|turn on|turn off) (\d+),(\d+) through (\d+),(\d+)$/;
  my ($command, $x1, $y1, $x2, $y2) = ($1, $2, $3, $4, $5);
  for my $x ($x1 .. $x2){
    for my $y ($y1 .. $y2){
      if($command eq "toggle"){$grid[$x][$y] += 2;}
      if($command eq "turn on"){$grid[$x][$y] += 1;}
      if($command eq "turn off"){if($grid[$x][$y] > 0){$grid[$x][$y] -= 1;}}
    }
  }
}

open my $handle, "< 06.txt";
while(my $instruction = <$handle>){
  interpret($instruction);
}

my $sum = 0;
for my $i (@grid){
  for my $c (@$i){
    $sum += $c;
  }
}

print $sum;