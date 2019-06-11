use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my $sum;
foreach my $line (@input){
  $line =~ /^(.+)(\d\d\d)\[(\w+)\]$/;
  my ($hash, $id, $checkSum) = ($1, $2, $3);
  if($checkSum eq calcCheckSum($hash)){
    $sum += $id;
  }
}

print "$sum\n";


sub calcCheckSum{
  my ($hash) = @_;
  my %count;
  foreach my $letter (split("", $hash)){
    $count{$letter} += ord($letter) - 10000 if($letter ne '-');
  }
  my @weasel = sort {$count{$a} <=> $count{$b}} keys(%count);
  return join("", @weasel[0..4]);
}
