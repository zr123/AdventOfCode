use strict;
use warnings;

sub check1 {
  my $pw = $_[0];
  for(my $i = 0; $i < length($pw)-2; ++$i){
    my $char = substr($pw, $i, 1);
    if(substr($pw, $i+1, 1) eq ++$char && substr($pw, $i+2, 1) eq ++$char){
      return 1;
    }
  }
  return 0;
}

sub check2 {
  my $pw = $_[0];
  if($pw =~ /[iol]/){
    return 0;
  }else{
    return 1;
  }
}

sub check3 {
  my $pw = $_[0];
  if($pw =~ /(.)\1.*([^\1])\2/){
    return 1;
  }
  return 0;
}

my $string = "cqjxxyzz";
++$string;
while(not(check1($string)) || not(check2($string)) || not(check3($string))){++$string;}
print "$string\n";