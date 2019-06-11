use strict;
use warnings;

open my $HANDLE, "<", "day2.txt";
my @instructions = <$HANDLE>;
close $HANDLE;

my @pad = ( [ 0 ,  0 , "1",  0 ,  0 ],
            [ 0 , "2", "3", "4",  0 ],
            ["5", "6", "7", "8", "9"],
            [ 0 , "A", "B", "C",  0 ],
            [ 0 ,  0 , "D",  0,   0 ]);            
my ($pos_x, $pos_y) = (0, 2);

foreach my $line (@instructions){
  foreach my $inst (split("", $line)){
    move($inst);
  }
  print $pad[$pos_y][$pos_x];
}
print "\n";



sub move{
  my ($direction) = @_;
  my ($x, $y) = ($pos_x, $pos_y);
  $y-- if $direction eq "U";
  $x++ if $direction eq "R";
  $y++ if $direction eq "D";
  $x-- if $direction eq "L";
  if(checkSanity($x, $y)){
    ($pos_x, $pos_y) = ($x, $y);
  }
}

sub checkSanity{
  my ($x, $y) = @_; 
  return 0 if($x > 4);
  return 0 if($y > 4);
  return 0 if($x < 0);
  return 0 if($y < 0);
  return 0 unless($pad[$y][$x]);
  return 1;
}