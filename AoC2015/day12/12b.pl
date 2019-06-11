use strict;
use warnings;

use JSON qw(decode_json);
use Scalar::Util qw(looks_like_number);

sub handler {
  my $weasel = $_[0];
  my $sum = 0;
  my $type = ref $weasel;
  if($type eq ""){
    return $weasel;
  }
  if($type eq "ARRAY"){
    foreach my $i (@$weasel){
      my $tmp = handler($i);
      if(looks_like_number($tmp)){
        $sum += $tmp;
      }
    }
    return $sum;
  }
  if($type eq "HASH"){
    foreach my $i (values(%$weasel)){
      my $tmp = handler($i);
      if(looks_like_number($tmp)){
        $sum += $tmp;
      }
      if($tmp eq "red"){
        return 0;
      }
    }
    return $sum;
  }
  print "ERROR";
}

open my $handle, "< 12.txt";
my $json = <$handle>;
close $handle;

my $decoded = decode_json($json);

print handler($decoded) . "\n";