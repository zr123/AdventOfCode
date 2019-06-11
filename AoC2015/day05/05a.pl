use strict;
use warnings;

sub test1 {
  my $string = $_[0];
  if($string =~ /[aeiou].*[aeiou].*[aeiou]/){
    return 1;
  }else{
    return 0;
  }
}

sub test2 {
  my $string = $_[0];
  if($string =~ /(.)\1/){
    return 1;
  }else{
    return 0;
  }
}

sub test3 {
  my $string = $_[0];
  if($string =~ /(ab|cd|pq|xy)/){
    return 0;
  }else{
    return 1;
  }
}

open my $handle, "< 05.txt";
my $count = 0;
while(my $s = <$handle>){
  if(test1($s) && test2($s) && test3($s)){
    $count++;
  }
}
close $handle;
print "$count\n";