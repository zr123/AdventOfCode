use strict;
use warnings;
use Test::More tests => 23;
use AoC2018::Day02;
use File::Slurp;

my @examples = ("abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab");
my @input = read_file("input/AoC2018/day02.txt");

is( Day02::twice($examples[0]),     0 );
is( Day02::thrice($examples[0]),    0 );
is( Day02::twice($examples[1]),     1 );
is( Day02::thrice($examples[1]),    1 );
is( Day02::twice($examples[2]),     1 );
is( Day02::thrice($examples[2]),    0 );
is( Day02::twice($examples[3]),     0 );
is( Day02::thrice($examples[3]),    1 );
is( Day02::twice($examples[4]),     1 );
is( Day02::thrice($examples[4]),    0 );
is( Day02::twice($examples[5]),     1 );
is( Day02::thrice($examples[5]),    0 );
is( Day02::twice($examples[6]),     0 );
is( Day02::thrice($examples[6]),    1 );
is( Day02::part1(@examples),       12 );

is( Day02::part1(@input),        4940 );

my @boxIds =("abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz");

is( Day02::difference($boxIds[0], $boxIds[5]),          2 );
is( Day02::difference($boxIds[5], $boxIds[0]),          2 );
is( Day02::difference($boxIds[1], $boxIds[4]),          1 );
is( Day02::difference($boxIds[4], $boxIds[1]),          1 );
is( Day02::commonLetters($boxIds[1], $boxIds[4]),   "fgij");
is( Day02::part2(@boxIds),                          "fgij");

is( Day02::part2(@input),      "wrziyfdmlumeqvaatbiosngkc");
