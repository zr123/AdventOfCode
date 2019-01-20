package Day02;
use strict;
use warnings;

sub getCharCount {
    my ($word) = @_;
    my %charcount;
	for my $char (split('', $word)){
		$charcount{$char}++;
	}
    return %charcount;
}

sub twice {
	my ($id) = @_;
    my %charcount = getCharCount($id);
	for my $value (values(%charcount)){
		if($value == 2){
			return 1;
		}
	}
	return 0;
}

sub thrice {
	my ($id) = @_;
    my %charcount = getCharCount($id);
	for my $value (values(%charcount)){
		if($value == 3){
			return 1;
		}
	}
	return 0;
}

sub part1 {
	my (@boxIDs) = @_;
	my ($twices, $thrices);
	for my $id (@boxIDs){
		if (twice($id)){
			$twices++;
		}
		if (thrice($id)){
			$thrices++;
		}
	}
	return $twices * $thrices;
}

sub difference {
    my ($wordA, $wordB) = @_;
    my @charsA = split("", $wordA);
    my @charsB = split("", $wordB);
    my $difference = 0;
    for(my $i = 0; $i < scalar(@charsA); ++$i){
        if($charsA[$i] ne $charsB[$i]){
            $difference++;
        }
    }
	return $difference;
}

sub commonLetters {
    my ($wordA, $wordB) = @_;
    my @charsA = split("", $wordA);
    my @charsB = split("", $wordB);
    my $result = "";
    for(my $i = 0; $i < scalar(@charsA); ++$i){
        if($charsA[$i] eq $charsB[$i]){
            $result .= $charsA[$i];
        }
    }
    return $result;
}

sub part2 {
	my @boxIDs = @_;
    map(chomp, @boxIDs);
    for(my $i = 0; $i < scalar(@boxIDs); ++$i){
        for(my $c = $i+1; $c < scalar(@boxIDs); ++$c){
            if(difference($boxIDs[$i], $boxIDs[$c]) == 1){
                return commonLetters($boxIDs[$i], $boxIDs[$c]);
            }
        }
    }
}

1;