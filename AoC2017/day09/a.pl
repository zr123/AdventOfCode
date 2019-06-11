use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my $input = <$HANDLE>;
close $HANDLE;

chomp($input);
$input = removeCancelations($input);
$input = cleanGarbage($input);
print calcStreamGroupValue(1, $input);


sub calcStreamGroupValue {
	my ($depth, $groupStream) = @_;
	my $value = $depth;
	my @groups = smartSplit($groupStream);
	for(my $i = 0; $i < @groups; ++$i){
		unless(isGarbage($groups[$i])){
			$value += calcStreamGroupValue($depth+1, $groups[$i]);
		}
	}
	return $value;
}

sub smartSplit {
	my ($stream) = @_;
	my @groups;
	my $currentGroup = "";
	my $indentation = 0;
	my @charStream = split("", $stream);
	for(my $i = 1; $i < @charStream-1; ++$i){
		if($charStream[$i] eq '{'){
			$indentation++;
		}
		if($charStream[$i] eq '}'){
			$indentation--;
		}
		if($indentation == 0 && $charStream[$i] eq ','){
			push(@groups, $currentGroup);
			$currentGroup = "";
			next;
		}
		$currentGroup .= $charStream[$i];
	}
	if(length($currentGroup) > 0){
		push(@groups, $currentGroup);
	}
	return @groups;
}

sub cleanGarbage {
	my ($stream) = @_;
	my $groupsOnlyStream = "";
	my @charStream = split("", $stream);
	my $garbage = 0;
	for(my $i = 0; $i < @charStream; $i++){
		if(!$garbage && $charStream[$i] eq '<'){
			$garbage = 1;
			$groupsOnlyStream .= $charStream[$i];
		}
		if(!$garbage){
			$groupsOnlyStream .= $charStream[$i];
		}
		if($garbage && $charStream[$i] eq '>'){
			$garbage = 0;
			$groupsOnlyStream .= $charStream[$i];
		}
		
	}
	return $groupsOnlyStream;
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

