use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

for(my $i = 0; 1; ++$i){
  my $md5 = md5_hex("iwrupvqb" . $i);
  if($md5 =~ /^00000/){
    print "$i\n";
    last;
  }
}