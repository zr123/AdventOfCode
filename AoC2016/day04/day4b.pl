use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $sum;
foreach my $line (@input){
  $line =~ /^(.+)(\d\d\d)\[(\w+)\]$/;
  my ($hash, $id, $checkSum) = ($1, $2, $3);
  my $decryptedString;
  $decryptedString .= rotateChar($_, $id) foreach split("", $hash);
  if($decryptedString =~ /northpole/){
    print "$id\n";
    last;
  }
}


sub rotateChar{
  my ($char, $rotation) = @_;
  if($char eq "-"){return " ";}
  $rotation = $rotation % 26;
  $char = ord($char) + $rotation;
  if($char > 122){
    $char -= 26;
  }
  return chr($char);
}