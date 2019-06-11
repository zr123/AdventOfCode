use strict;
use warnings;

sub getSmallest {
  my ($a, $b, $c) = @_;
  my $t;
  if($a < $b){
    $t = $a;
  }else{
    $t = $b;
  }
  if($t < $c){
    return $t;
  }else{
    return $c;
  }
}

sub calcWrapping {
  my ($a, $b, $c) = @_;
  return 2*$a*$b + 2*$a*$c + 2*$b*$c + getSmallest($a*$b, $a*$c ,$b*$c);
}

open my $handle, "< 02.txt";
my @presents = <$handle>;
close $handle;

my $sum = 0;
for my $present (@presents){
  if($present =~ /(\d+)x(\d+)x(\d+)/){
    $sum += calcWrapping($1, $2, $3);
  }
}

print "$sum\n";