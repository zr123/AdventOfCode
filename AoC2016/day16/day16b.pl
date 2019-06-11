use warnings;
use strict;

my $input = "11110010111001001";
my $diskSpace = 35651584;

while(length($input) < $diskSpace){
  $input = dragonCurve($input);
}
$input = cutOffString($input, $diskSpace);
while(length($input) % 2 == 0){
  $input = calcCheckSum($input);
}
print "$input\n";


sub dragonCurve{
  my ($a) = @_;
  my $b = reverse($a);
  $b =~ s/1/X/g;
  $b =~ s/0/1/g;
  $b =~ s/X/0/g;
  return $a . "0" . $b;
}

sub cutOffString{
  my ($inputData, $amount) = @_;
  return substr($inputData, 0, $amount);
}

sub calcCheckSum{
  my ($string) = @_;
  my $checkSum = "";
  while($string =~ /([01])([01])/g){
    if($1 eq $2){
      $checkSum .= 1;
    }else{
      $checkSum .= 0;
    }
  }
  return $checkSum;
}