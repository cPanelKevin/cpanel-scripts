#!/usr/local/cpanel/3rdparty/bin/perl

# //////////////////////////////////////////////////////
# This script will generate an array of domains effected by a PHP configuration change,
# such as when a change is made in MultiPHP Manager.
# Install the script using:
#
# /usr/local/cpanel/bin/manage_hooks add script /root/scripts/setvhostver.pl --manual --category Whostmgr --event 'Lang::PHP::set_vhost_versions' --stage post
#
# Adjust the script path '/root/scripts/setvhostver.pl' if needed
# Set the execute bit on the script:
#
# chmod +x /root/scripts/setvhostver.pl
#
# Test using:
#
# whmapi1 php_set_vhost_versions vhost-0=cptech1.test vhost-1=cptech2.test
#
# Check the data provided by the script by viewing /root/scripts/setvhostver.log
# //////////////////////////////////////////////////////

use warnings;
use strict;

use Data::Dumper;
use Cpanel::JSON::XS;

my $input = (<>);
my $json  = decode_json $input;
my $data  = $json->{'data'};

# adjust path to logfile if needed
my $logfile = '/root/scripts/setvhostver.log';
open( my $fh, '>', $logfile )
  or die "Could not open file: $logfile $!\n";

my @domains = values %$data;
print $fh Dumper(@domains);

close $fh;
