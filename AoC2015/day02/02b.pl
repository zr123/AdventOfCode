use strict;
use warnings;

sub calcRibbonWrap {
  my ($a, $b, $c) = @_;
  if($c >= $a && $c >= $b){
    return 2*$a+2*$b;
  }
  if($a >= $b && $a >= $c){
    return 2*$b+2*$c;
  }
  if($b >= $a && $b >= $c){
    return 2*$a+2*$c;
  }
}

sub calcRibbon {
  my ($a, $b, $c) = @_;
  return $a*$b*$c;
}

open my $handle, "< 02.txt";
my @presents = <$handle>;
close $handle;

my $sum = 0;
for my $present (@presents){
  if($present =~ /(\d+)x(\d+)x(\d+)/){
    $sum += calcRibbonWrap($1, $2, $3) + calcRibbon($1, $2, $3);
  }
}

print "$sum\n";