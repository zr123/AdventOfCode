use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

chomp($input);
print calcDecrompressedStringLength($input) , "\n";

sub calcDecrompressedStringLength{
  my ($inputString) = @_;
  my $stringLength = 0;
  if($inputString =~ /\((\d+)x(\d+)\)/){
    my ($markerStart, $markerEnd, $sequenceLength, $factor) = ($-[0], $+[0], $1, $2);
    $stringLength += length(substr($inputString, 0, $markerStart)); #length of string before the marker
    $stringLength += calcDecrompressedStringLength(substr($inputString, $markerEnd, $sequenceLength)) * $factor; #length of the repetition-sequence * repetiton-factor
    $stringLength += calcDecrompressedStringLength(substr($inputString, $markerEnd + $sequenceLength)); #length of remainder of the string after repetition-sequence
  }else{
    $stringLength = length($inputString); #raw stringLength if no reptition-marker is found
  }
  return $stringLength;
}