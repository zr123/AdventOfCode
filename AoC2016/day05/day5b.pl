use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $input = "ffykfhsq";
my @password = ("", "", "", "", "", "", "", "");
my $count = 0;

for(my $i = 0; 1; ++$i){
  if(md5_hex($input . $i) =~ /^00000([0-7])(.)/){
    if($password[$1] eq ""){
      $password[$1] = $2;
      $count++;
      if($count == 8){
        last;
      }
    }    
  }
}

print join("", @password), "\n";