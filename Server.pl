#!/usr/bin/perl
#
# @File Server.pl
# @Author syahmizakir
# @Created May 11, 2016 7:53:42 PM
#
use strict;
use warnings;
use IO::Socket::SSL;

# auto-flush on socket
$| = 1;

# creating a listening socket
my $socket = new IO::Socket::SSL (
    LocalHost => '0.0.0.0',
    LocalPort => '4433',
    Listen => 5,
    Reuse => 1,
    SSL_cert_file => 'syahmi.crt',
    SSL_key_file => 'syahmi.key',
);
die "cannot create socket $!\n" unless $socket;
print "Connecting to Server on port 4433, Please wait\n";

# waiting for a new client connection
my $client = $socket->accept() or die "SSL_ERROR = $SSL_ERROR\n";

# get information about a newly connected client
my $client_address = $client->peerhost();
my $client_port = $client->peerport();
print "New connection from $client_address:$client_port\n";

# read from the connected client
my $data = "";
$client->read($data);
print "Received message: $data";

print "End\n";
shutdown($client, 1);
