use strict;
use warnings;

my $input = 329;
my $end = 2017;

my @state = (0);
my $position = 0;

while(@state <= 2017){
	$position += $input;
	$position %= @state;
	++$position;
	splice(@state, $position, 0, (scalar(@state)));
}

print $state[$position+1];