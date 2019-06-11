use strict;
#use warnings; // we are accessing loads of unitialized values of %happiness with myself here

use Algorithm::Permute;

open my $handle, "< 13.txt";
my @raw = <$handle>;
my (@people, %happiness);

for my $i (@raw){
  $i =~ /^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+).$/;
  my ($person1, $person2, $gain) = ($1, $4, $2 eq "gain"? $3:-$3);
  $happiness{$person1 . "|" . $person2} += $gain;
  if(not grep(/$person1/, @people)){
    push @people, $person1;
  }
}

push @people, "myself"; #add myself to the table;

my $iterator = Algorithm::Permute->new(\@people);
my $max = 0;
while(my @p = $iterator->next){
  my $total = 0;
  $total += $happiness{$p[0] . "|" . $p[-1]} + $happiness{$p[-1] . "|" . $p[0]};
  for(my $i = 0; $i < scalar(@p)-1; ++$i){
    $total += $happiness{$p[$i] . "|" . $p[$i+1]} + $happiness{$p[$i+1] . "|" . $p[$i]};
  }
  if($total > $max){
    $max = $total;
  }
}
print "$max\n";