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

sub generatePicture {
	my ($imagedata, $heigth, $width) = @_;
	my @layers = splitLayers($imagedata, $heigth, $width);
	my $picture = "";
	for(my $i = 0; $i < $heigth*$width; ++$i){
		foreach my $layer (@layers){
			my $pixel = substr($layer, $i, 1);
			if($pixel ne 2){
				$picture .= $pixel;
				last;
			}
		}
	}
	return $picture;
}

sub part2 {
	my ($imagedata) = @_;
	my $picture = generatePicture($imagedata, 6, 25);
	$picture =~ s/0/ /g;
	$picture =~ s/1/#/g;
	for(my $i = 0; $i < 6*25; $i += 25){
		print substr($picture, $i, 25) . "\n";
	}
	return "JAFRA";
}

1;