use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

chomp($input);
$input = removeCancelations($input);
print getGarbageValue($input);



sub getGarbageValue {
	my ($stream) = @_;
	my $garbageValue;
	my @charStream = split("", $stream);
	my $garbage = 0;
	for(my $i = 0; $i < @charStream; $i++){
		if($garbage && $charStream[$i] eq '>'){
			$garbage = 0;
		}
		if($garbage){
			$garbageValue++;
		}
		if(!$garbage && $charStream[$i] eq '<'){
			$garbage = 1;
		}
	}
	return $garbageValue;
}

sub removeCancelations {
	my ($stream) = @_;
	while($stream =~ s/!.//g){};
	return $stream;
}

sub isGarbage {
	my ($subStream) = @_;
	my @charStream = split("", $subStream);
	if($charStream[0] eq '<' && $charStream[-1] eq '>'){
		return 1;
	}
	return 0;
}

