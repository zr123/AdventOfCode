use strict;
use warnings;

my %info;
$info{"children"} = 3;
$info{"cats"} = 7;
$info{"samoyeds"} = 2;
$info{"pomeranians"} = 3;
$info{"akitas"} = 0;
$info{"vizslas"} = 0;
$info{"goldfish"} = 5;
$info{"trees"} = 3;
$info{"cars"} = 2;
$info{"perfumes"} = 1;

sub check {
  my ($key, $value) = @_;
  if($key eq "cats" || $key eq "trees"){
    return $info{$key} < $value;
  }
  if($key eq "pomeranians" || $key eq "goldfish"){
    return $info{$key} > $value;
  }
  return $info{$key} == $value;
}

open HANDLE, "< 16.txt";
while(my $sue = <HANDLE>){
  $sue =~ /^Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)$/;
  if(!check($2, $3)){next;}
  if(!check($4, $5)){next;}
  if(!check($6, $7)){next;}
  print "$1\n";
}
close HANDLE;