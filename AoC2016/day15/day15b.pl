use strict;
use warnings;

my @discPositionCount;
my @discCurrentPosition;
my $discCount = 0;

open my $HANDLE, "<", "input.txt";
handleInput($_) while(<$HANDLE>);
close $HANDLE;

addDisc(11, 0);

moveDiscIntoRelativePositions();
my $time = 0;
while(!checkDiscStates()){
  moveAllDiscsForward();
  $time++;
}

print "$time\n";


sub handleInput{
  my ($line) = @_;
  $line =~ /^Disc #\d has (\d+) positions; at time=0, it is at position (\d+)\.$/;
  $discPositionCount[$discCount] = int($1);
  $discCurrentPosition[$discCount] = int($2);
  $discCount++;
}

sub moveDiscForward{
  my ($disc) = @_;
  $discCurrentPosition[$disc] += 1;
  if($discCurrentPosition[$disc] >= $discPositionCount[$disc]){
    $discCurrentPosition[$disc] = 0;
  }
}

sub moveDiscIntoRelativePositions{
  for(my $i = 0; $i < $discCount; ++$i){
    for(my $c = 0; $c < $i+1; ++$c){
      moveDiscForward($i);
    }
  }
}

sub moveAllDiscsForward{
  for(my $i = 0; $i < $discCount; ++$i){
    moveDiscForward($i);
  }
}

sub checkDiscStates{
  for(my $i = 0; $i < $discCount; ++$i){
    if($discCurrentPosition[$i] != 0){
      return 0;
    }
  }
  return 1;
}

sub addDisc{
  my ($positionCount, $currentPosition) = @_;
  $discPositionCount[$discCount] = $positionCount;
  $discCurrentPosition[$discCount] = $currentPosition;
  $discCount++;
}