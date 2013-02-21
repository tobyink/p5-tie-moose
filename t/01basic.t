use strict;
use warnings;
use Test::More;
use Test::Fatal;

use Tie::Moose;

{
	package Loose;
	use Moose;
	has foo => (is => 'rw');
	has bar => (is => 'ro');
	has baz => (is => 'rw', clearer => '_clear_baz');
	__PACKAGE__->meta->make_immutable;
	no Moose;
}

my $object = Loose->new(bar => 123, baz => 456);
tie my %hash, "Tie::Moose", $object;

is($hash{foo}, undef);
is($hash{bar}, 123);
is($hash{baz}, 456);

is( exception { $hash{foo} = 789 }, undef );
like( exception { $hash{bar} = 789 }, qr{^No writer for attribute 'bar' in tied object} );

like( exception { delete $hash{foo} }, qr{^No clearer for attribute 'foo' in tied object} );
like( exception { delete $hash{bar} }, qr{^No clearer for attribute 'bar' in tied object} );
is( exception { delete $hash{baz} }, undef );

like( exception { my $xyz = $hash{xyz} }, qr{^No attribute 'xyz' in tied object} );

done_testing;
