use strict;
use warnings;

sub calcValue {
  my ($sugar, $sprinkles, $candy, $chocolate) = @_;
  my $capacity = 3*$sugar - 3*$sprinkles - $candy;
  my $durability = 3*$sprinkles;
  my $flavor = 4*$candy - 2*$chocolate;
  my $texture = -3*$sugar + 2*$chocolate;
  #print "$capacity * $durability * $flavor * $texture\n";
  if($capacity <= 0 || $durability <= 0 || $flavor <= 0 || $texture <= 0){
    return 0;
  }
  return $capacity * $durability * $flavor * $texture;
}

#some semi-random starting values
my ($sugar, $sprinkles, $candy, $chocolate) = (6, 1, 14, 10);
while($sugar + $sprinkles + $candy + $chocolate < 100){
  my ($v1, $v2, $v3, $v4) = (
    calcValue($sugar+1, $sprinkles, $candy, $chocolate),
    calcValue($sugar, $sprinkles+1, $candy, $chocolate),
    calcValue($sugar, $sprinkles, $candy+1, $chocolate),
    calcValue($sugar, $sprinkles, $candy, $chocolate+1));
  if($v1 >= $v2 && $v1 >= $v3 && $v1 >= $v4){$sugar++;next;}
  if($v2 >= $v1 && $v2 >= $v3 && $v2 >= $v4){$sprinkles++;next;}
  if($v3 >= $v1 && $v3 >= $v2 && $v3 >= $v4){$candy++;next;}
  if($v4 >= $v1 && $v4 >= $v2 && $v4 >= $v3){$chocolate++;next;}
}

print "$sugar, $sprinkles, $candy, $chocolate = " . calcValue($sugar, $sprinkles, $candy, $chocolate) . "\n";
print calcValue(21, 5, 31, 43) . "\n";