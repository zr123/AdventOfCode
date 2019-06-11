use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

my @programs = split("", "abcdefghijklmnop");

for(my $turn = 0; $turn < 100; ++$turn){
	print $_ for @programs;
	print "\n";
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
}

print $_ for @programs;