use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @sortedBlacklist = sort{
  $a =~ /^(\d+)-/;
  my $c = $1;
  $b =~ /^(\d+)-/;
  my $d = $1;
  $c <=> $d
} @input;

my $nextPossibleIP = 0;
my $i = 0;
while(1){
  $sortedBlacklist[$i] =~ /^(\d+)-(\d+)$/;
  my ($fromIP, $toIP) = ($1, $2);
  if($nextPossibleIP < $fromIP){
    print "$nextPossibleIP\n";
    last;
  }
  if($nextPossibleIP < $toIP+1){
    $nextPossibleIP = $toIP+1;
  }
  $i++;
}