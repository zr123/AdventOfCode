use strict;
use warnings;

sub lookAndSay {
  my $string = $_[0];
  my $result = "";
  while(length $string > 0){
    if($string =~ s/^(\d)\1*//){
      $result .= length($&) . $1;
    }
  }
  return $result;
}

my $string = "1321131112";
for(my $i = 0; $i < 40; ++$i){
  $string = lookAndSay $string;
}

print length($string) . "\n";