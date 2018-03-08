#!/usr/local/cpanel/3rdparty/bin/perl

# this script will generate an array of domains effected by a PHP configuration change

# install the script using:
## /usr/local/cpanel/bin/manage_hooks add script /root/scripts/inputdumper.pl --manual --category Whostmgr --event 'Accounts::Create' --stage post
# adjust the script path '/root/scripts/inputdumper.pl' if needed
# set the execute bit on the script
## chmod +x /root/scripts/inputdumper.pl
# test using:
## whmapi1 php_set_vhost_versions vhost-0=domain1.test vhost-1=domain2.test

use warnings;
use strict;

use Data::Dumper;
use Cpanel::JSON::XS;

my $input = (<>);
my $json  = decode_json $input;
my $data  = $json->{'data'};

# adjust path to logfile if needed
my $logfile = '/root/scripts/input.log';
open( my $fh, '>', $logfile )
  or die "Could not open file: $logfile $!\n";

my @domains = values %$data;
print $fh Dumper(@domains);

close $fh;
