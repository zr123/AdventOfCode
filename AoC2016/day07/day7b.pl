use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $count = 0;
foreach my $line (@input){
  if(checkSSLSupport($line)){
    $count++;
  }
}

print "$count\n";


sub checkSSLSupport{
  my ($ip) = @_;
  my @hypernetSequences;
  while($ip =~ s/\[(\w+)\]/[]/){
    push(@hypernetSequences, $1);
  }
  while($ip =~ /(\w)(?=(\w)\1)/g){
    my $BAB = "$2$1$2";
    foreach my $sequence (@hypernetSequences){
      if($sequence =~ /$BAB/){
        return 1;
      }
    }
  }
  return 0;
}

