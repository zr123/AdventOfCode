use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $input = "ffykfhsq";
my $password = "";
for(my $i = 0; 1; ++$i){
  if(md5_hex($input . $i) =~ /^00000(.)/){
    $password .= $1;
    if(length($password) == 8){
      last;
    }    
  }
}

print "$password\n";