use strict;
use warnings;

open my $HANDLE, "<", "day3.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $count = 0;

foreach my $line (@input){
  my @sides = split(" ", $line);
  @sides = sort {$a <=> $b} @sides;
  if($sides[0] + $sides[1] > $sides[2]){++$count};
}

print "$count\n";