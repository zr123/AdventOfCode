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

sub calcCalories {
  my ($sugar, $sprinkles, $candy, $chocolate) = @_;
  return 2*$sugar + 9*$sprinkles + $candy + 8*$chocolate;
}

#trail and error
my ($sugar, $sprinkles, $candy, $chocolate) = (21, 8, 26, 45);
#print $sugar + $sprinkles + $candy + $chocolate . "\n";
print calcValue($sugar, $sprinkles, $candy, $chocolate) . "\n";
#print calcCalories($sugar, $sprinkles, $candy, $chocolate) . "\n";