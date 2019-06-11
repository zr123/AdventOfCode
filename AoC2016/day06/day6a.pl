use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

# rotate for easier management
my @lines;
foreach my $line (@input){
  my @letters = split("", $line);
  for(my $i = 0; $i < length($line); ++$i){
    $lines[$i] .= $letters[$i];
  }
}

my $message;
$message .= getMostCommonChar($_) foreach @lines;
print "$message\n";

sub getMostCommonChar{
  my ($string) = @_;
  my %count;
  $count{$_}++ foreach split("", $string);
  my @rates = sort {$count{$b} <=> $count{$a}} keys(%count);
  return $rates[0];
}