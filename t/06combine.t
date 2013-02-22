use strict;
use warnings;
use Test::More;
use Test::Fatal;

use Tie::Moose;

ok defined exception { Tie::Moose->with_traits(qw/ FallbackSlot FallbackHash /) };
ok defined exception { Tie::Moose->with_traits(qw/ FallbackSlot Forgiving /) };
ok defined exception { Tie::Moose->with_traits(qw/ FallbackHash Forgiving /) };

done_testing;
