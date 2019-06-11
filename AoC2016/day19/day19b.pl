use strict;
use warnings;

my @table;
my $input = 3018458;

# init
for(my $i = 0; $i < $input; ++$i){
  $table[$i] = $i+1;
}

# magic takes roughly 5 minutes -> rewrite in c;
my $elfesLeft = $input;
my $currentPosition = 0;
my $starttime = time;

while($elfesLeft > 1){
  #print "($currentPosition, $elfesLeft) ";
  #print $_, " " foreach @table;
  my $stealFromPosition = steal($currentPosition, $elfesLeft);
  $elfesLeft--;
  # wenn vor der derzeitigen position gestohlem wird, rutschten alle elemente im Array nach und es muss nicht inkrementiert werden
  if($stealFromPosition < $currentPosition){  
    $currentPosition--;
  }
  $currentPosition = smartInc($currentPosition, $elfesLeft);
  #print "\n";
}

print @table, "\n";
print "took: " . (time - $starttime) . " seconds";
#26735 is wrong and too low :(

# functions 
sub steal{
  my ($elfNumber, $elfsRemaining) = @_;
  my $stealFromNumber = getElfAcross($elfNumber, $elfsRemaining);
  splice(@table, $stealFromNumber, 1);
  return $stealFromNumber;
}

sub getElfAcross{
  my ($position, $elfsRemaining) = @_;
  my $oppositeElf = $position + int($elfsRemaining/2);
  if($oppositeElf >= $elfsRemaining){
    $oppositeElf -= $elfsRemaining;
  }
  return $oppositeElf;
}

sub smartInc{
  my ($position, $elfsRemaining) = @_;
  $position++;
  if($position >= $elfsRemaining){
    return $position - $elfsRemaining;
  }
  return $position;
}