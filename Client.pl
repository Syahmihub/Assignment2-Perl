#!/usr/bin/perl
#
# @File Client.pl
# @Author syahmizakir
# @Created May 7, 2016 7:53:20 PM
#
use strict;
use warnings;
use IO::Socket::SSL;
use Getopt::Long qw(:config posix_default bundling);

my $addr = 'localhost';
my $port = '4433';

my $client = IO::Socket::SSL->new(
    PeerAddr => $addr,
    PeerPort => $port,
    SSL_version => 'TLSv1',    # Use TLS version 1
    SSL_verify_mode => 0,
) or die "failed to connect to $addr: $!,$SSL_ERROR";

# View certificate detail
warn "New SSL connection with cipher=".$client->get_cipher." version=".$client->get_sslversion." certificate:\n".
    "\tsubject=".$client->peer_certificate('subject')."\n".
    "\tissuer=".$client->peer_certificate('issuer')."\n";


print "Enter message to send to the server: ";
my $msg = <STDIN>;
# message to send to a server
print $client $msg;

print "End\n";
shutdown($client, 1);
