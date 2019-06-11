use strict;
use warnings;

open my $handle, "< 19.txt";
my @rules;
my $molecule;
while(<$handle>){
  if(/\w+ => \w+$/){
    push @rules, $_;
  }else{
    $molecule = $_;
  }
}

sub applyRuleBackwards {
  my ($rule, $molecule) = @_;
  $rule =~ /^(\w+) => (\w+)$/;
  my ($orig, $replacement) = ($1, $2);
  if($molecule =~ s/$replacement/$orig/){
    return $molecule;
  }
  return "";
}

my $count = 0;
my $fuermartin = 1;
while($fuermartin){
  $fuermartin = 0;
  for my $rule (@rules){
    my $tmp = applyRuleBackwards($rule, $molecule);
    if($tmp ne ""){
      $count++;
      $molecule = $tmp;
      $fuermartin = 1;
    }
  }
}

print "$count\n";