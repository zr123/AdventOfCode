use strict;
use warnings;

open my $HANDLE, "<", "day1.txt";
my $input = <$HANDLE>;
close $HANDLE;
my @instructions = split(", ", $input);
my %state = (direction => 0, pos_x => 0, pos_y => 0);   # 0 = north, 1 = east, 2 = south, 3 = west
my %history;

foreach my $inst (@instructions){
  $inst =~ /([RL])(\d+)/;
  turn($1);
  move($2);
}



sub turn{
    my ($direction) = @_;
    if($direction eq "R"){
        $state{direction}++;
        if($state{direction} == 4){
            $state{direction} = 0;
        }
    }else{
        $state{direction}--;
        if($state{direction} == -1){
            $state{direction} = 3;
        }
    }
}

sub move{
  for(my ($length) = @_; $length > 0; $length--){
    $state{pos_y}++ if($state{direction} == 0);
    $state{pos_x}++ if($state{direction} == 1);
    $state{pos_y}-- if($state{direction} == 2);
    $state{pos_x}-- if($state{direction} == 3);
    if(++$history{"($state{pos_x})($state{pos_y})"} > 1){
      print abs($state{pos_x}) + abs($state{pos_y}), "\n";
      die();
    }
  }
}
