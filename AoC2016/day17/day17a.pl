use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $LIMIT = 4;
my $input = "edjrjqaa";

my @moves = getOpenDirections($input, "", 0, 0);
@moves = cleanUpDirections(@moves);

my $loop = 1;
while($loop){
  my @nextmoves = ();
  foreach my $move (@moves){
    push(@nextmoves, getOpenDirections($input, @$move));
  }
  @moves = cleanUpDirections(@nextmoves);
  
  foreach my $position (@moves){
    if(checkGoalPosition(@{$position})){
      print ${$position}[0] . "\n";
      $loop = 0;
    }
  }
}


sub getOpenDirections{
  my ($input, $direction, $x, $y) = @_;
  my @possibleDirections = ();
  my $md5 = md5_hex($input . $direction);
  if($md5 =~ /^[b-f].../){
    push(@possibleDirections, [$direction . "U", $x, $y-1]);
  }
  if($md5 =~ /^.[b-f]../){
    push(@possibleDirections, [$direction . "D", $x, $y+1]);
  }
  if($md5 =~ /^..[b-f]./){
    push(@possibleDirections, [$direction . "L", $x-1, $y]);
  }
  if($md5 =~ /^...[b-f]/){
    push(@possibleDirections, [$direction . "R", $x+1, $y]);
  }
  return @possibleDirections;
}

sub checkBounds{
  my ($x, $y) = @_;
  if($x < 0 || $x >= $LIMIT){return 0;}
  if($y < 0 || $y >= $LIMIT){return 0;}
  return 1;
}

sub cleanUpDirections{
  my (@possibleMoves) = @_;
  my @returnArray = ();
  for(my $i = 0; my $moveRef = $possibleMoves[$i]; ++$i){
    if(checkBounds(${$moveRef}[1], ${$moveRef}[2])){
      push(@returnArray, $moveRef);
    }
  }
  return @returnArray;
}

sub checkGoalPosition{
  my ($path, $x, $y) = @_;
  if($x == $LIMIT-1 && $y == $LIMIT-1){
    return 1;
  }
  return 0;
}