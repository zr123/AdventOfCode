use strict;
use warnings;

open my $handle, "< 03.txt";
my $directions = <$handle>;
close $handle;

my %children;
my ($x, $y) = (0, 0);  #santa starting location
my ($xR, $yR) = (0, 0);  #robo santa starting location
my $movement = 0; # 0 = santa; 1 = Robosanta
$children{$x . "/" . $y}++;
$children{$xR . "/" . $yR}++;

sub move {
  my ($x, $y, $direction) = @_;
  if($direction eq '^'){
    $y++;
  }
  if($direction eq 'v'){
    $y--;
  }
  if($direction eq '>'){
    $x++;
  }
  if($direction eq '<'){
    $x--;
  }
  return ($x, $y);
}

for(my $i = 0;$i < length($directions);++$i){
  if($movement == 0){
    ($x, $y) = move($x, $y, substr($directions, $i, 1));
    $children{$x . "/" . $y}++;
  }
  if($movement == 1){
    ($xR, $yR) = move($xR, $yR, substr($directions, $i, 1));
    $children{$xR . "/" . $yR}++;
  }
  $movement = not($movement);
}

my $count = 0;
for my $child (values(%children)){
  $count++;
}

print "$count\n";