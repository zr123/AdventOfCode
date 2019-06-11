use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

my @programs = split("", "abcdefghijklmnop");
#$input = "s1,x3/4,pe/b";

for my $command (split(",", $input)){
	if($command =~ /^s(\d+)$/){
		for(my $i = 0; $i < $1; ++$i){
			unshift(@programs, pop(@programs));
		}
	}
	if($command =~ /^x(\d+)\/(\d+)$/){
		($programs[$1], $programs[$2]) = ($programs[$2], $programs[$1]);
	}
	if($command =~ /^p(\w)\/(\w)$/){
		my ($index1, $index2);
		for(my $i = 0; $i < @programs; ++$i){
			if($1 eq $programs[$i]){$index1 = $i;}
			if($2 eq $programs[$i]){$index2 = $i;}
		}
		($programs[$index1], $programs[$index2]) = ($programs[$index2], $programs[$index1]);
	}
}

my @mP; #movementPattern
for(my $i = 0; $i < @programs; ++$i){
	$mP[$i] = ord($programs[$i]) -97;
}

#print $_ for @programs;
#print "\n";
#@programs = split("", "abcdefghijklmnop");
for(my $turn = 1; $turn < 10; ++$turn){
	@programs = 
		(	$programs[$mP[0]],
			$programs[$mP[1]],
			$programs[$mP[2]],
			$programs[$mP[3]],
			$programs[$mP[4]],
			$programs[$mP[5]],
			$programs[$mP[6]],
			$programs[$mP[7]],
			$programs[$mP[8]],
			$programs[$mP[9]],
			$programs[$mP[10]],
			$programs[$mP[11]],
			$programs[$mP[12]],
			$programs[$mP[13]],
			$programs[$mP[14]],
			$programs[$mP[15]]);
}

print $_ for @programs;
#print "$_\n" for @mP;