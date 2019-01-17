package Day01;
use strict;
use warnings;
use File::Slurp;

sub part1 {
    my ($input) = @_;
    $input =~ s/[,\r\n]//g;
    return eval($input);
}

sub part2 {
    my ($input) = @_;
    $input =~ s/[,\r\n]//g;
    my %reachedFrequencies = (0 => 1);
    my $currentFrequency = 0;
    while(1){
        while($input =~ /(-?\d+)/g){
            $currentFrequency += eval($1);
            if($reachedFrequencies{$currentFrequency}){
                return $currentFrequency;
            } else {
                $reachedFrequencies{$currentFrequency} = 1;
            }
        }
    }
}

1;