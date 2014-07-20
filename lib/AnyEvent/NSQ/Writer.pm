package AnyEvent::NSQ::Writer;

# ABSTRACT: a NSQ.io asynchronous producer
# VERSION
# AUTHORITY

use strict;
use warnings;
use Carp 'croak';

use parent 'AnyEvent::NSQ::Client';

#### Producer API

## Publish a single message - callback is only called if we succedd
sub publish {
  my ($self, $topic, $data, $cb) = @_;

  my $conn = $self->_random_connected_conn;
  croak "ERROR: there no active connections at this moment," unless $conn;

  $cb = sub { $cb->($self, $topic, $data, @_) }
    if $cb;

  return $conn->publish($topic, $data, $cb);
}



1;
