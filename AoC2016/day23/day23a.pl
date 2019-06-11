use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @instructions = <$HANDLE>;
close $HANDLE;

my %registry = (a => 7, b => 0, c => 0, d => 0);
my $offset = 0;

while($offset < scalar(@instructions)){
  handleInstruction($instructions[$offset]);
}

#print "$offset   a = " . $registry{a} . "\n\n";
#print "$_" foreach @instructions;
print $registry{a} , "\n";


sub handleInstruction{
  my ($instruction) = @_;
  # increment
  if($instruction =~ /^inc (\D)$/){
    $registry{$1}++;
  }
  # decrement
  if($instruction =~ /^dec (\D)$/){
    $registry{$1}--;
  }
  # copy barevalue to registry
  if($instruction =~ /^cpy (-?\d+) (\D)$/){
    $registry{$2} = $1;
  }
  # copy registryvalue to registry
  if($instruction =~ /^cpy (\D) (\D)$/){
    $registry{$2} = $registry{$1};
  }
  # jnz registry barevalue
  if($instruction =~ /^jnz (\D) (-?\d+)$/){
    if($registry{$1} != 0){
      $offset += $2 -1;
    }
  }
  # jnz barevale barevalue
  if($instruction =~ /^jnz (-?\d+) (-?\d+)$/){
    if($1 != 0){
      $offset += $2 -1;
    }
  }
  # jnz registry registry
  if($instruction =~ /^jnz (\D) (\D)$/){
    if($registry{$1} != 0){
      $offset += $registry{$2} -1;
    }
  }
  # jnz barevale registry
  if($instruction =~ /^jnz (-?\d+) (\D)$/){
    if($1 != 0){
      $offset += $registry{$2} -1;
    }
  }
  # tgl registry
  if($instruction =~ /^tgl (\D)$/){
    toggle($offset + $registry{$1});
  }
  # tgl barevalue
  if($instruction =~ /^tgl (-?\d+)$/){
    toggle($offset + $1);
  }
  $offset++;
}

sub toggle{
  my ($line) = @_;
  if($instructions[$line] =~ s/^inc/dec/){return;}
  if($instructions[$line] =~ s/^(dec|tgl)/inc/){return;}
  if($instructions[$line] =~ s/^jnz/cpy/){return;}
  if($instructions[$line] =~ s/^(cpy)/jnz/){return;}
}