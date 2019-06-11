use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;
chomp($input);

my @field = ($input);

for(my $line = 0; $line < 39; ++$line){
  my @splitLine = split("", "." . $field[$line] . ".");
  my $nextLine = "";
  for(my $i = 1; $i < scalar(@splitLine)-1; ++$i){
    $nextLine .= check($splitLine[$i-1], $splitLine[$i], $splitLine[$i+1]);
  }
  push(@field, $nextLine);
}

$field[0] = join("", @field);
@field = split("", $field[0]);
my $count = 0;
$_ eq "."? $count++:0 foreach @field;
print "$count\n";

sub check{
  my ($left, $middle, $right) = @_;
  if($left eq "^" && $middle eq "^" && $right eq "."){
    return "^";
  }
  if($left eq "." && $middle eq "^" && $right eq "^"){
    return "^";
  }
  if($left eq "^" && $middle eq "." && $right eq "."){
    return "^";
  }
  if($left eq "." && $middle eq "." && $right eq "^"){
    return "^";
  }
  return ".";
}