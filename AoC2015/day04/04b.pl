#use strict;
#use warnings;

use Digest::MD5;
while(Digest::MD5::md5_hex("iwrupvqb" . ++$i) !~ /^0{6}/ or die "$i\n"){};