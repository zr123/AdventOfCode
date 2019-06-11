use strict;
use warnings;

open my $HANDLE, "<", "day3.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $count = 0;

# don't judge me, too lazy too do it properly
for(my $i = 0; $i < scalar(@input); $i += 3){
  my @line1 = split(" ", $input[$i]);
  my @line2 = split(" ", $input[$i+1]);
  my @line3 = split(" ", $input[$i+2]);
  my @row1 = sort {$a <=> $b} ($line1[0], $line2[0], $line3[0]);
  my @row2 = sort {$a <=> $b} ($line1[1], $line2[1], $line3[1]);
  my @row3 = sort {$a <=> $b} ($line1[2], $line2[2], $line3[2]);
  if($row1[0] + $row1[1] > $row1[2]){++$count};
  if($row2[0] + $row2[1] > $row2[2]){++$count};
  if($row3[0] + $row3[1] > $row3[2]){++$count};
}

print "$count\n";