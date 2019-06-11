use strict;
use warnings;

# Papierlösung: 43 too high
# Verbesserte Papierlösung: 41 too high
# Verbesserte Papierlösung: 39 too high
# Lösung 33 erraten

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @floor;
my %generators;
my %chips;
for(my $i = 0 ; $i < scalar(@input); ++$i){
  print "\nfloor $i:\n";
  handleInput($i, $input[$i]);
}


sub handleInput{
  my ($floorNumber, $line) = @_;
  while($line =~ / (\w+) generator/g){
    $generators{$1} = $floorNumber;
  }
  print "\nchips: ";
  while($line =~ / (\w+)-compatible microchip/g){
    $chips{$1} = $floorNumber;
  }
}