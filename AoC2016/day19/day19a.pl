use strict;
use warnings;


my @table;
my $input = 3018458;

# init
for(my $i = 0; $i < $input; ++$i){
  $table[$i] = 1;
}

# magic, takes up to a few minutes
my $currentPosition = 0;
while(1){
  if($table[$currentPosition] != 0){
    unless(steal($currentPosition)){
      print ++$currentPosition, "\n";
      last;
    }
  }
  $currentPosition = smartInc($currentPosition);
}


sub steal{
  my ($elfNumber) = @_;
  my $stealFromNumber = smartInc($elfNumber);
  while($table[$stealFromNumber] == 0){
    $stealFromNumber = smartInc($stealFromNumber);
  }
  if($elfNumber != $stealFromNumber){
    $table[$elfNumber] += $table[$stealFromNumber];
    $table[$stealFromNumber] = 0;
    return 1;
  }else{
    return 0;
  }
}

sub smartInc{
  my ($position) = @_;
  $position++;
  if($position >= $input){
    return 0;
  }else{
    return $position;
  }
}