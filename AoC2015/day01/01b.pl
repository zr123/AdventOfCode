use strict;
use warnings;

open my $handle, "< 01.txt";
my $text = <$handle>;
close $handle;

my $floor = 0;
my $i = 0;
for(; $floor >= 0; $i++){
  if(substr($text,$i,1) eq '('){
    $floor++;
  }else{
    $floor--;
  }
}

print "$i\n";