use strict;
use warnings;

open my $handle, "< 03.txt";
my $directions = <$handle>;
close $handle;

my %children;
my ($x, $y) = (0, 0);  #starting location
$children{$x . "/" . $y}++;

for(my $i = 0;$i < length($directions);++$i){
  if(substr($directions, $i, 1) eq '^'){
    $y++;
  }
  if(substr($directions, $i, 1) eq 'v'){
    $y--;
  }
  if(substr($directions, $i, 1) eq '>'){
    $x++;
  }
  if(substr($directions, $i, 1) eq '<'){
    $x--;
  }
  $children{$x . "/" . $y}++;
}


my $count = 0;
for my $child (values(%children)){
  $count++;
}

print "$count\n";