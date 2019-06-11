use strict;
use warnings;

open HANDLE, "< 14.txt";
my %reindeers;
while(my $t = <HANDLE>){
  $t =~ /^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/;
  $reindeers{$1} = [$2, $3, $4];
}
close HANDLE;

my $TIME = 2503;
my $max = 0;
while(my ($reindeer, $speed) = each(%reindeers)){
  my $cycle = $$speed[1] + $$speed[2];
  my $distance = int($TIME / $cycle) * $$speed[0] * $$speed[1];
  my $remainingTime = $TIME % $cycle;
  if($remainingTime < $$speed[1]){
    $distance += $remainingTime * $$speed[0];
  }else{
    $distance += $$speed[0] * $$speed[1];
  }
  if($distance > $max){
    $max = $distance;
  }
}

print "$max\n";