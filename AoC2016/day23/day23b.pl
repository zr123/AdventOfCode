use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @instructions = <$HANDLE>;
close $HANDLE;

my %registry = (a => 12, b => 0, c => 0, d => 0);
my $offset = 0;
my $limit = scalar(@instructions);
while($offset < $limit){
  handleInstruction($instructions[$offset]);
}

# 479009700, takes several hours
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
  # jump
  if($instruction =~ /^jnz (\S+) (\S+)$/){
    jump($1, $2);
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


sub jump{
  my ($operant1, $operant2) = @_;
  my ($value1, $value2);
  if($operant1 =~ /(-?\d+)/){
    $value1 = $operant1;
  }else{
    $value1 = $registry{$operant1};
  }
  if($operant2 =~ /(-?\d+)/){
    $value2 = $operant2;
  }else{
    $value2 = $registry{$operant2};
  }
  if($value1 != 0 && $value2 != 0){
    $offset += $value2 -1;
  }
}

sub toggle{
  my ($line) = @_;
  if($line >= scalar(@instructions)){return;}
  if($instructions[$line] =~ s/^inc/dec/){return;}
  if($instructions[$line] =~ s/^(dec|tgl)/inc/){return;}
  if($instructions[$line] =~ s/^jnz/cpy/){return;}
  if($instructions[$line] =~ s/^cpy/jnz/){return;}
}