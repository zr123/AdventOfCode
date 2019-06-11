use strict;
use warnings;
use List::MoreUtils;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @password = split("", "fbgdceah");

foreach my $line (reverse(@input)){
  handleInstruction(\@password, $line);
}

print join("", @password), "\n";



sub handleInstruction{
  my ($hashRef, $instruction) = @_;
  if($instruction =~ /^swap position (\d) with position (\d)$/){
    swapPosition($hashRef, $1, $2);
    return;
  }
  if($instruction =~ /^swap letter (\w) with letter (\w)$/){
    swapLetter($hashRef, $1, $2);
    return;
  }
  if($instruction =~ /^reverse positions (\d) through (\d)$/){
    reversePositions($hashRef, $1, $2);
    return;
  }
  if($instruction =~ /^rotate (left|right) (\d+) steps?$/){
    rotatePositions($hashRef, $1, $2);
    return;
  }
  if($instruction =~ /^move position (\d) to position (\d)$/){
    movePosition($hashRef, $1, $2);
    return;
  }
  if($instruction =~ /^rotate based on position of letter (\w)$/){
    #die "$instruction";
    rotateBasedOnPosition($hashRef, $1);
    return;
  }
  die("unhandled instruction: $instruction");
}

sub swapPosition{
  my ($hashRef, $pos_a, $pos_b) = @_;
  my $swap = $$hashRef[$pos_a];
  $$hashRef[$pos_a] = $$hashRef[$pos_b];
  $$hashRef[$pos_b] = $swap;
}

sub swapLetter{
  my ($hashRef, $letter_a, $letter_b) = @_;
  my $tmpHash = join("", @$hashRef);
  $tmpHash =~ s/$letter_a/x/;
  $tmpHash =~ s/$letter_b/$letter_a/;
  $tmpHash =~ s/x/$letter_b/;
  @$hashRef = split("", $tmpHash);
}

sub reversePositions{
  my ($hashRef, $pos_a, $pos_b) = @_;
  @$hashRef[$pos_a..$pos_b] = reverse(@$hashRef[$pos_a..$pos_b]);
}

sub rotatePositions{
  my ($hashRef, $direction, $steps) = @_;
  if($direction eq "right"){
    while($steps--){
      my $tmp = shift(@$hashRef);
      push(@$hashRef, $tmp);
    }
  }else{
    while($steps--){
      my $tmp = pop(@$hashRef);
      unshift(@$hashRef, $tmp);
    }
  }
}

sub movePosition{
  my ($hashRef, $toPos, $fromPos) = @_;
  my $elem = splice(@$hashRef, $fromPos, 1);
  splice(@$hashRef, $toPos, 0, ($elem));
}

sub rotateBasedOnPosition{
  my ($hashRef, $letter) = @_;
  my $index = List::MoreUtils::first_index {$_ eq $letter} @$hashRef;
  my $rotation;
  #see rotation_analysis.txt file
  if($index == 1){$rotation = 1;}
  if($index == 3){$rotation = 2;}
  if($index == 5){$rotation = 3;}
  if($index == 7){$rotation = 4;}
  if($index == 2){$rotation = 6;}
  if($index == 4){$rotation = 7;}
  if($index == 6){$rotation = 8;}
  if($index == 0){$rotation = 9;}
  rotatePositions($hashRef, "right", $rotation);
}