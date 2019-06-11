use strict;
use warnings;

my $sum = 0;
open my $handle, "< 08.txt";
while(my $line = <$handle>){
  chomp($line);
  $sum += length($line) - length(eval($line));
}
close($handle);
print "$sum\n";