use 5.010;
use strict;
use warnings;

package Tie::Moose::FallbackHash;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.001';

use Moose::Role;

has _fallback_hash => (
	is       => 'ro',
	isa      => 'Ref',
	required => 1,
	init_arg => 'fallback',
);

sub fallback
{
	my $self = shift;
	my ($operation, $key, $value) = @_;
	my $hash = $self->_fallback_hash;
	
	given ($operation) {
		when ("FETCH")  { return $hash->{$key} }
		when ("STORE")  { return $hash->{$key} = $value }
		when ("EXISTS") { return exists $hash->{$key} }
		when ("DELETE") { return delete $hash->{$key} }
		default         { confess "This should never happen!" }
	}
}

no Moose::Role;

1;

__END__

=head1 NAME

Tie::Moose::FallbackHash - provide a fallback hashref for unknown attributes

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Tie-Moose>.

=head1 SEE ALSO

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

