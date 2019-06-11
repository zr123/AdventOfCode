use strict;
use warnings;

sub interpret {
  my ($pointer, $instruction, %reg) = @_;
  if($instruction =~ /^(hlf|tpl|inc|jmp|jie|jio) ([\w+-]+)(?:, ([\w+-]+))?$/){
    if($1 eq "hlf"){
      $reg{$2} = int($reg{$2}/2);
    }
    if($1 eq "tpl"){
      $reg{$2} = $reg{$2}*3;
    }
    if($1 eq "inc"){
      $reg{$2}++;
    }
    if($1 eq "jmp"){
      $pointer += $2 -1;
    }
    if($1 eq "jie" && $reg{$2} % 2 == 0){
      $pointer += $3 -1;
    }
    if($1 eq "jio" && $reg{$2} == 1){
      $pointer += $3 -1;
    }
  }
  return ($pointer, %reg);
}

open my $handle, "< 23.txt";
my @program = <$handle>;
close $handle;

my $pointer = -1;
my %registry;
$registry{"a"} = $registry{"b"} = 0;
while(++$pointer < scalar(@program)){
  ($pointer, %registry) = interpret($pointer, $program[$pointer], %registry);
}

print "$registry{b}\n";