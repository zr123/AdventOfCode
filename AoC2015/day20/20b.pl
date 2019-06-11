use strict;
use warnings;

my @list;
my $MAX = 1000000;

for(my $i = 1; $i <= $MAX; ++$i){
  $list[$i] = 1;
}
for(my $i = 2; $i <= $MAX; ++$i){
  my $counter = 0;
  for(my $n = $i; $n <= $MAX && $counter < 50; $n += $i){
    $list[$n] += $i;
    ++$counter;
  }
}

for(my $i = 1; $i < $MAX; ++$i){
  if($list[$i] >= 36000000/11){
    print "$i\n";
    last;
  }
}