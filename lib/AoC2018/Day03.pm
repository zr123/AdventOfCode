package Day03;
use strict;
use warnings;
use Data::Dumper qw(Dumper);

sub claim {
    my ($claim, @fabric) = @_;
    $claim =~ /^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/;
    my ($id, $x, $y, $x2, $y2) = ($1, $2, $3, $4, $5);
    my $c = 0;
    for(my $xi = $x; $xi < $x + $x2; ++$xi){
        for(my $yi = $y; $yi < $y + $y2; ++$yi){
            $fabric[$yi][$xi] += 1;
        }
    }
    return @fabric;
}

sub part1 {
    my (@claims) = @_;
    map(chomp, @claims);
    my @fabric;
    for my $claim (@claims){
        @fabric = claim($claim, @fabric);
    }
    print Dumper \@fabric;
    my $count = 0;
    for my $row (@fabric){
        for my $tile (@{$row}){
            if(defined($tile) && $tile > 1){
                $count++;
            }
        }
    }
    return $count;
}

1;