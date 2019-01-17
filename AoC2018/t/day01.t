use strict;
use warnings;
use Test::More tests => 9;
use Day01;


is( Day01::part1("+1, -2, +3, +1"),             3  );
is( Day01::part1("+1, +1, +1"),                 3  );
is( Day01::part1("+1, +1, -2"),                 0  );
is( Day01::part1("-1, -2, -3"),                -6  );

is( Day01::part2("+1, -2, +3, +1"),             2  );
is( Day01::part2("+1, -1"),                     0  );
is( Day01::part2("+3, +3, +4, -2, -4"),        10  );
is( Day01::part2("-6, +3, +8, +5, -6"),         5  );
is( Day01::part2("+7, +7, -2, -7, -4"),        14  );
