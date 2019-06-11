use strict;
use warnings;

open HANDLE, "< 14.txt";
my %reindeers;
while(my $t = <HANDLE>){
  $t =~ /^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/;
  my %deer;
  $deer{"Speed"} = $2;
  $deer{"DashPeriod"} = $3;
  $deer{"RestPeriod"} = $4;
  $deer{"Status"} = 1;
  $deer{"Points"} = 0;
  $deer{"Distance"} = 0;
  $deer{"Countdown"} = $3;
  $reindeers{$1} = \%deer;
}
close HANDLE;

for(my $i = 0; $i < 2503; ++$i){
  my $maxdistance = 0;
  while(my ($name, $deer) = each(%reindeers)){
    if($$deer{"Status"}){
      $$deer{"Distance"} += $$deer{"Speed"};
    }
    if($$deer{"Distance"} > $maxdistance){
      $maxdistance = $$deer{"Distance"};
    }
    $$deer{"Countdown"}--;
    if($$deer{"Countdown"} == 0){
      $$deer{"Status"} = !$$deer{"Status"};
      if($$deer{"Status"}){
        $$deer{"Countdown"} = $$deer{"DashPeriod"};
      }else{
        $$deer{"Countdown"} = $$deer{"RestPeriod"};
      }
    }
  }
  while(my ($name, $deer) = each(%reindeers)){
    if($$deer{"Distance"} == $maxdistance){
      $$deer{"Points"}++;
    }
  }
}

my $maxpoints = 0;
while(my ($name, $deer) = each(%reindeers)){
  if($$deer{"Points"} > $maxpoints){
    $maxpoints = $$deer{"Points"};
  }
}

print "$maxpoints\n";