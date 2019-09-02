#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use DBI;
use Getopt::Std;
use feature "say";

my %opts;
getopts( 'p:n:t:', \%opts );
my $pv   = $opts{p};
my $name = $opts{n};
my $url = $opts{t};


sub usage {
	my $help = <<USAGE;

Usage: $0 -p <platform version> -n <name> -t <repo url>
    
Options:
    -p Platform version. Example : "REDHAT LINUX 7".
    -n Repository name.
    -t Repository url. Must point to repodata directory.

USAGE
	die("$help");
}

if (!$pv or !$name or !$url ) {
	usage();
}

#DB Privilege
my $db ="NUMDB";
my $user = "numadm";
my $pass = "Solusicerdas*2019";
my $host = "172.16.1.212:3306";

my $dbh = DBI->connect("dbi:mysql:$db:$host",$user,$pass, {RaiseError=>1} ) or die "Cannot connect to database";


sub get_dev_id {
	my $platform_vers = shift;
	my $dev_id = "";
	my $sql = "SELECT id
            FROM NUMDB_DEVICE
            WHERE platform_vers = ?";
	my @trow = $dbh->selectrow_array($sql,undef,$platform_vers);
	unless (@trow) { die "Platform '$platform_vers' Not Found \n"; }
	($dev_id) = @trow;
	
	return $dev_id;
}


sub insert_repodata {

	my $platform_vers = shift;
	my $repo_name = shift;
	my $repo_url = shift;
	my $dev_id = get_dev_id($platform_vers);
	my $sql = "INSERT INTO NUMDB_DEVICE_DATA VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE dev_key = ?, value = ?";
	my $trow1 =  $dbh->do($sql, undef,"$dev_id","repo_name","$repo_name","repo_name","$repo_name");
	my $trow2 =  $dbh->do($sql, undef,"$dev_id","repo_url","$repo_url","repo_url","$repo_url");

	if (!$trow1 or !$trow2){
		print "ERROR: ".$DBI::errstr."\n";
	} else {
		print "successfully insert repo data " . "'$repo_name'" . "\n";
	}
}

insert_repodata($pv,$name,$url);

$dbh->disconnect();