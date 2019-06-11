use strict;
use warnings;

my @list;
my $MAX = 1000000;

for(my $i = 1; $i <= $MAX; ++$i){
  $list[$i] = 1;
}
for(my $i = 2; $i <= $MAX; ++$i){
  for(my $n = $i; $n <= $MAX; $n += $i){
    $list[$n] += $i;
  }
}

for(my $i = 1; $i < $MAX; ++$i){
  if($list[$i] >= 36000000/10){
    print "$i\n";
    last;
  }
}