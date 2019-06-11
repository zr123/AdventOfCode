use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
my @lengths = split(",", $input);
close $HANDLE;

my @knots;
for(my $i = 0; $i < 256; ++$i){
	push(@knots, $i);
}

my $position = 0;

for(my $skipSize = 0; $skipSize < @lengths; ++$skipSize){
	@knots = circularReverse($position, $lengths[$skipSize], @knots);
	$position += $lengths[$skipSize] + $skipSize;
	$position %= scalar(@knots);
}

print $knots[0] * $knots[1];





sub circularReverse {
	my ($from, $len, @list) = @_;
	my $size = @list;
	push(@list, @list);
	@list[$from .. ($from+$len-1)] = reverse(@list[$from .. ($from+$len-1)]);
	if(($from+$len-1) >= $size){
		@list[0..(($from+$len-1)%$size)] = @list[$size..($from+$len-1)];
	}
	return @list[0..($size-1)];
}