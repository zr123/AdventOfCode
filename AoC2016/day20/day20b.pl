use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
chomp foreach @input;
close $HANDLE;

my @sortedBlacklist = sort{
  $a =~ /^(\d+)-/;
  my $c = $1;
  $b =~ /^(\d+)-/;
  my $d = $1;
  $c <=> $d
} @input;

my $i = 0;
while($i+1 < scalar(@sortedBlacklist)){
  my ($currFromIP, $currToIP) = split('-', $sortedBlacklist[$i]);
  my ($nextFromIP, $nextToIP) = split('-', $sortedBlacklist[$i+1]);
  if($nextFromIP <= $currToIP+1){
    if($nextToIP > $currToIP){
      $sortedBlacklist[$i] = join('-', ($currFromIP, $nextToIP));
    }else{
      $sortedBlacklist[$i] = join('-', ($currFromIP, $currToIP));
    }
    splice(@sortedBlacklist, $i+1, 1);
  }else{
    $i++;
  }
}

my $count = 0;
foreach my $range (@sortedBlacklist){
  my ($currFromIP, $currToIP) = split('-', $range);
  $count += ($currToIP-$currFromIP)+1;
}

print 2**32 - $count;