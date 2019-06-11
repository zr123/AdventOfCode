use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $input = "yjdafjpo";
my @hashes;
my @answers;
my $LIMIT = 30000; #arbitrary

my $cHash = calcHashes(0, $LIMIT);

for(my $i = 0; $i < $LIMIT; ++$i){
  while($hashes[$i] =~ /(.)\1\1\1\1/g){
    my $letter = $1;
    my $tmp = $i - 1000;
    $tmp = 0 if $tmp < 0;
    for(my $c = $tmp; $c < $i; ++$c){
      if($hashes[$c] =~ /(.)\1\1/){
        if($1 eq $letter){
          push(@answers, $c);
        }
      }
    }
  }
}

@answers = sort {$a <=> $b} @answers;
print "$answers[63]\n";

sub calcHashes{
  my ($currentHash, $nextHash) = @_;
  while($currentHash < $nextHash){
    push(@hashes, stretchedMD5_hex($input . $currentHash));
    $currentHash++;
  }
  return $currentHash;
}

sub stretchedMD5_hex{
  my ($input) = @_;
  for(my $i = 0; $i <= 2016; ++$i){
    $input = md5_hex($input);
  }
  return $input;
}