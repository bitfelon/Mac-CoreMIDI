package Mac::CoreMIDI::Port;

use 5.006;
use strict;
use warnings;

use base qw(Mac::CoreMIDI::Object);
our $VERSION = '0.05';

sub ctlout {
	my $class = shift;

	my ($note, $velocity) = @_;
	if ($note > 127 || $velocity > 127 || $note < 0 || $velocity < 0 || $note !~ /^\d+$/ || $velocity !~ /^\d+$/)
	{
		die "must send cc value/velocity to ctlout()\n";
	}

	return $class->out(0xB0, $note, $velocity);
}

sub noteout {
	my $class = shift;

	my ($note, $velocity) = @_;
	if ($note > 127 || $velocity > 127 || $note < 0 || $velocity < 0 || $note !~ /^\d+$/ || $velocity !~ /^\d+$/)
	{
		die "must send note/velocity to noteout()\n";
	}

	return $class->out($velocity ? 0x90 : 0x80, $note, $velocity);
}

sub out {
		my $class = shift;
		return _out($class, @_);
}

sub new_input {
    my $class = shift;
    my %args = @_;

    return undef unless ref($args{client});
    $args{name} ||= 'Mac::CoreMIDI::Port (Input)';

    my $self = _new_input($class, $args{client}, $args{name});

    return $self;
}

sub new_output {
    my $class = shift;
    my %args = @_;

    return undef unless ref($args{client});
    $args{name} ||= 'Mac::CoreMIDI::Port (Output)';

    my $self = _new_output($class, $args{client}, $args{name});

    return $self;
}

sub _DESTROY {
    _destroy(shift);
}

sub Read {
    # nothing happens here right now
}

1;

__END__

=head1 NAME

Mac::CoreMIDI::Port - Encapsulates a CoreMIDI Port

=head1 CONSTRUCTORS

=over 4

=item C<my $ep = Mac::CoreMIDI::Port->new_input(name => '...', client => $client)

Creates a new input port for the given client.

=item C<my $ep = Mac::CoreMIDI::Port->new_output(name => '...', client => $client)

Creates a new output port for the given client.

=back

=head1 METHODS

=over

=item C<$self-E<gt>Read()>

Subclass this function to do processing on read events.

=back

=head1 SEE ALSO

L<Mac::CoreMIDI>

=head1 AUTHOR

Bit Felon, E<lt>bitfelon @ bitfelon.comE<gt>

Christian Renz, E<lt>crenz @ web42.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2005 Christian Renz, E<lt>crenz @ web42.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut