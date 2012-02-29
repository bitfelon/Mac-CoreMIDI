#!/usr/bin/perl

use lib qw(lib ../blib/arch);
use strict;
use warnings;

use Mac::CoreMIDI;

my $client = Mac::CoreMIDI::Client->new(name => 'bitharp');
my $mp = Mac::CoreMIDI::Port->new_output(name => 'bitharpmp', client => $client);

# send CC 0 value of 60 (or $ARGV[0])
$mp->ctlout(0, shift || 60);

# play a note at velocity 50 (out of 127) for 1 second
$mp->noteout(100, 50);
sleep 1;
$mp->noteout(100, 0);

