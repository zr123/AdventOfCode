use strict;
use warnings;

open my $HANDLE, "<", "day2.txt";
my @instructions = <$HANDLE>;
close $HANDLE;

my ($x, $y) = (1, 1);

foreach my $line (@instructions){
  foreach my $inst (split("", $line)){
    move($inst);
  }
  print $y*3 + $x + 1;
}
print "\n";



sub move{
  my ($direction) = @_;
  $y-- if $direction eq "U";
  $x++ if $direction eq "R";
  $y++ if $direction eq "D";
  $x-- if $direction eq "L";
  sanitize();
}

sub sanitize{
  $x = 2 if($x > 2);
  $y = 2 if($y > 2);
  $x = 0 if($x < 0);
  $y = 0 if($y < 0);
}