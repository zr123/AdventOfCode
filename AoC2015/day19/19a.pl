use strict;
use warnings;

open my $handle, "< 19.txt";
my @rules;
my $molecule;
while(<$handle>){
  if(/^\w+ => \w+$/){
    push @rules, $_;
  }else{
    $molecule = $_;
  }
}

my %hash;
sub applyRule {
  my ($rule, $molecule) = @_;
  $rule =~ /^(\w+) => (\w+)$/;
  my ($orig, $replacement) = ($1, $2);
  my $sum = 0;
  $molecule =~ s/$orig/-/g;
  while($molecule =~ /-/g){
    my $copy = $molecule;
    $copy =~ s/-/$replacement/;
    $copy =~ s/-/$orig/g;
    $hash{$copy} = 1;
    $molecule =~ s/-/$orig/;
  }
}

my $s = 0;
for my $rule (@rules){
  $s += applyRule($rule, $molecule);
}

print scalar(values(%hash)) . "\n";