use strict;
use warnings;
use Test::More tests => 15;
use Day02;

my @examples = ("abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab");

is( Day02::twice($examples[1]),     0 );
is( Day02::thrice($examples[1]),    0 );
is( Day02::twice($examples[2]),     1 );
is( Day02::thrice($examples[2]),    1 );
is( Day02::twice($examples[3]),     1 );
is( Day02::thrice($examples[3]),    0 );
is( Day02::twice($examples[4]),     0 );
is( Day02::thrice($examples[4]),    1 );
is( Day02::twice($examples[5]),     1 );
is( Day02::thrice($examples[5]),    0 );
is( Day02::twice($examples[6]),     1 );
is( Day02::thrice($examples[6]),    0 );
is( Day02::twice($examples[7]),     0 );
is( Day02::thrice($examples[7]),    1 );

is( Day02::part1(@examples),       12 );
