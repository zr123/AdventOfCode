use strict;
use warnings;

my @list = (43,3,4,10,21,44,4,6,47,41,34,17,17,44,36,31,46,9,27,38);

sub weasel {
  my ($sum, @derp) = @_;
  my $count = 0;
  for(my $i = 0; $i < scalar(@derp); ++$i){
    my $tmpsum = $sum + $derp[$i];
    if($tmpsum < 150){
      $count += weasel($tmpsum, @derp[($i+1) .. (scalar(@derp)-1)]);
    }
    if($tmpsum == 150){
      $count++;
    }
  }
  return $count;
}

print weasel(0, @list) . "\n";