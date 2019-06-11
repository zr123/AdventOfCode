use strict;
#use warnings;
# warnings aus weil massiv auf uninitialisierte Variablen zugegriffen wird

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my %var;
for my $line (@input){
	$line =~ s/inc/+=/;
	$line =~ s/dec/-=/;
	$line =~ s/(\d)$/$1\);/;
	$line =~ s/ if ([a-z]+)/ if\(\$var\{$1\}/;
	$line =~ s/^([a-z]+)/\$var\{$1\}/;
	eval($line);
}

my $MAXIMUM = 0;
for my $VALUE (values(%var)){
	if($VALUE > $MAXIMUM){
		$MAXIMUM = $VALUE;
	}
}

print $MAXIMUM;