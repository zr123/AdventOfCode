use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

chomp($input);
print length(decompress($input)) , "\n";

sub decompress{
  my ($inputString) = @_;
  my $returnString = "";
  while($inputString =~ s/\((\d+)x(\d+)\)//){
    $returnString .= substr($inputString, 0, $-[0]);
    $returnString .= substr($inputString, $-[0], $1) x $2;
    $inputString = substr($inputString, $-[0] + $1);
  }
  $returnString .= "$inputString";
  return $returnString;
}