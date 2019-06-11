use strict;
use warnings;

use List::Util "sum";

open my $handle, "< 24.txt";
my @presents = <$handle>;
close $handle;

#find possible combinations of the fewest number of presents whose sum yields exactly $total
@presents = sort {$b <=> $a} @presents; # sort descending
my $total = sum(@presents)/3;

# observation a: we need an even number of presents in each location, since all the numbers in the puzzle input are uneven and $total is even
# observation b: since the 4 largest values don't add up to $total, the next possible number is 6 presents
# since the smallest number of presents is prefered, we need to pick 6 presents with the smallest entanglement

my ($optimalCount, $optimalQE) = (6, 999999999999); #current best solution

my $count = 0;
sub weasel {
  my ($sum, $presentCount, $offset, @values) = @_;
  if($sum > $total){return;}
  if($sum == $total){
    if($values[0] * $values[1] * $values[2] * $values[3] * $values[4] * $values[5] < $optimalQE){
      $optimalQE = $values[0] * $values[1] * $values[2] * $values[3] * $values[4] * $values[5];
    }
  }
  if($presentCount == $optimalCount){return;}
  for(my $i = $offset; $i < scalar(@presents); ++$i){
    weasel($sum + $presents[$i], $presentCount+1, $i+1, (@values,$presents[$i]));
  }
}

weasel(0, 0, 0, ());
print "$optimalQE Done\n";