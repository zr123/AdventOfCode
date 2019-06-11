use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;
chomp($input);

my $line = $input;
my $count = 0;
$_ eq "."? $count++:0 foreach split("", $line);
my $startingTime = time();

for(my $lineCount = 0; $lineCount < 399999; ++$lineCount){
  my @splitLine = split("", "." . $line . ".");
  my $nextLine = "";
  for(my $i = 1; $i < scalar(@splitLine)-1; ++$i){
    if(check($splitLine[$i-1], $splitLine[$i], $splitLine[$i+1])){
      $nextLine .= "^";
    }else{
      $nextLine .= ".";
      $count++;
    }
  }
  $line = $nextLine;
}

#print "took " . (time() - $startingTime) . " seconds! \n";
print "$count \n";

sub check{
  my ($left, $middle, $right) = @_;
  if($left eq "^" && $middle eq "^" && $right eq "."){
    return 1;
  }
  if($left eq "." && $middle eq "^" && $right eq "^"){
    return 1;
  }
  if($left eq "^" && $middle eq "." && $right eq "."){
    return 1;
  }
  if($left eq "." && $middle eq "." && $right eq "^"){
    return 1;
  }
  return 0;
}