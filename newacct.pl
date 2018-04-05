#!/usr/local/cpanel/3rdparty/bin/perl

# //////////////////////////////////////////////////////
# This script will check if a new account is a reseller
# Install the script using:
#
# /usr/local/cpanel/bin/manage_hooks add script /root/scripts/newacct.pl --manual --category Whostmgr --event 'Accounts::Create' --stage post
#
# Adjust the script path '/root/scripts/newacct.pl' if needed
# Set the execute bit on the script:
#
# chmod +x /root/scripts/newacct.pl
#
# Test using:
#
# whmapi1 createacct username=cptech domain=cptech.test password=$(openssl rand -base64 12)
#
# Check the data provided to the script by viewing /root/scripts/newacct.log
# To isolate an input value, try something like:
# my $username = $data->{'user'};
#
# //////////////////////////////////////////////////////

use warnings;
use strict;

use Data::Dumper;
use Cpanel::JSON::XS;

my $input = (<>);
my $json  = decode_json $input;
my $data  = $json->{'data'};

# adjust path to logfile if needed
my $logfile = '/root/scripts/newacct.log';
open( my $fh, '>', $logfile )
  or die "Could not open file: $logfile $!\n";

print $fh Dumper($data);

close $fh;
