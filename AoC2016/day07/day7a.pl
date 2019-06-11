use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $count = 0;
foreach my $line (@input){
  if(checkTLSSupport($line)){
    $count++;
  }
}

print "$count\n";


sub checkTLSSupport{
  my ($ip) = @_;
  my @hypernetSequences;
  while($ip =~ s/\[(\w+)\]/[]/){
    push(@hypernetSequences, $1);
  }
  foreach my $sequence (@hypernetSequences){
    if(($sequence =~ /(\w)(\w)\2\1/) && ($& !~ /(\w)\1\1\1/)){
      return 0;
    }
  }
  if(($ip =~ /(\w)(\w)\2\1/) && ($& !~ /(\w)\1\1\1/)){
    return 1;
  }
  return 0;
}