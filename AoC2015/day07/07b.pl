use strict;
use warnings;

my %circuit;
open my $handle, "< 07.txt";
while(<$handle>){
  if($_ =~ /^(.*) -> (.*)$/){
    $circuit{$2} = $1;
  }
}
close $handle;

sub subAndDelete {
  my $element = $_[0];
  my $comand = $circuit{$element};
  delete $circuit{$element};
  for my $k (keys %circuit){
    $circuit{$k} =~ s/\b$element\b/$comand/;
  }
}

sub evaluate {
  my $element = $_[0];
  if($circuit{$element} =~ /^(\d+) (AND|OR|LSHIFT|RSHIFT) (\d+)$/){
    my ($left, $operator, $right) = ($1, $2, $3);
    if($operator eq "AND"){$circuit{$element} = int($left) & int($right); return 1;}
    if($operator eq "OR"){$circuit{$element} = int($left) | int($right); return 1;}
    if($operator eq "LSHIFT"){$circuit{$element} = int($left) << int($right); return 1;}
    if($operator eq "RSHIFT"){$circuit{$element} = int($left) >> int($right); return 1;}
  }
  if($circuit{$element} =~ /NOT (\d+)$/){
    $circuit{$element} = ~int($1);
    return 1;
  }
  return 0;
}

$circuit{"b"} = 46065; #overwrite
subAndDelete "c";
subAndDelete "b";
while(scalar(keys %circuit) > 1){
  for my $k (keys %circuit){
    if(evaluate $k){
      subAndDelete $k;
    }
  }
}
  
while(my ($k, $v) = each %circuit){
  print "$v -> $k\n";
}