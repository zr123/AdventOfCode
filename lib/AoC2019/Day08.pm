package Day08;
use strict;
use warnings;


sub splitLayers {
	my ($imagedata, $heigth, $width) = @_;
	chomp($imagedata);
	my $layersize = $heigth * $width;
	my @layers;
	for(my $i = 0; $i < length($imagedata); $i += $layersize){
		push(@layers, substr($imagedata, $i, $layersize));
	}
	return @layers;
}

sub countDigits {
	my ($layer, $digit) = @_;
	my $count = () = ($layer =~ /$digit/g);
	return 0 + $count;
}

sub part1 {
	my ($imagedata) = @_;
	my @layers = splitLayers($imagedata, 6, 25);
	my ($smallestZeroCount, $value) = (6*25, 0);
	foreach my $layer (@layers){
		my $zeroes = countDigits($layer, 0);
		if($zeroes < $smallestZeroCount){
			$smallestZeroCount = $zeroes;
			$value = countDigits($layer, 1) * countDigits($layer, 2);
		}
	}
	return $value;
}

1;