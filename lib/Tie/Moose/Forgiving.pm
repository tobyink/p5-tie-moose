use 5.010;
use strict;
use warnings;

package Tie::Moose::Forgiving;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.001';

use Moose::Role;
use Carp qw(croak);
use Scalar::Does -constants;

override fallback => sub
{
	my $self = shift;
	my ($operation, $key, $value) = @_;
	
	given ($operation) {
		when ("FETCH")  { return; }
		when ("STORE")  { super; }
		when ("EXISTS") { return; }
		when ("DELETE") { return; }
		default         { confess "This should never happen!" }
	}
};

no Moose::Role;

1;

__END__

=head1 NAME

Tie::Moose::Forgiving - don't die at the mere mention of an unknown key

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

