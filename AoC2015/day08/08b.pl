use strict;
use warnings;

my $sum = 0;
open my $handle, "< 08.txt";
while(<$handle>){
  chomp;
  s/[^"\\]//g;
  $sum += length($_) + 2;
}
close($handle);
print "$sum\n";