use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

chomp($input);
my $hash = adventOfCodeHash($input);
print $hash;


sub adventOfCodeHash {
	my ($stringInput) = @_;
	
	# covert to ASCII-Values
	my @lengths;
	for my $char (split("", $stringInput)){
		push(@lengths, ord($char));
	}
	
	# add fixed length end
	push(@lengths, (17, 31, 73, 47, 23));
	
	# run hash-algorythm
	my @knots;
	for(my $i = 0; $i < 256; ++$i){
		push(@knots, $i);
	}
	my $position = 0;
	for(my $skipSize = 0; $skipSize < @lengths*64; ++$skipSize){
		@knots = circularReverse($position, $lengths[$skipSize%@lengths], @knots);
		$position += $lengths[$skipSize%@lengths] + $skipSize;
		$position %= scalar(@knots);
	}
	
	return convertToHexString(@knots);
}

sub convertToHexString {
	my (@numbers) = @_;
	my $hexString;
	for(my $i = 0; $i < @numbers; $i+=16){
		my $hex = listXOR(@numbers[$i..$i+15]);
		$hexString .= sprintf("%02x", $hex);
	}
	return $hexString;
}

sub listXOR {
	my (@list) = @_;
	my $xor = pop(@list);
	#print $xor . " ";
	while(@list){
		#print $list[-1] . " ";
		$xor ^= pop(@list);
	}
	return $xor;
}

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