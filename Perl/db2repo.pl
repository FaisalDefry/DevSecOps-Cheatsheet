#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use DBI;
use Getopt::Std;
use feature "say";

my $repo_id;
my $repo_name;
my $repo_url;
my $base_dir = "/root/numisec-automation";
my $out_dir = $base_dir . "/playbooks/patching/files" ;
#my $out_dir = "." ;
my $pv = $ARGV[0];


sub usage {
	my $help = <<USAGE;
Usage: $0 <platform version> 
    

USAGE
	die("$help");
}

if (!$pv ) {
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
	my $query = "SELECT id
            FROM NUMDB_DEVICE
            WHERE platform_vers = ?";
	my @trow = $dbh->selectrow_array($query,undef,$platform_vers);
	unless (@trow) { die "Platform '$platform_vers' Not Found \n"; }
	($dev_id) = @trow;
	return $dev_id;
}

sub create_repoconfig {
	my $platform_vers = shift;
	my $dev_id = get_dev_id($platform_vers);
	my $sql = "select value from NUMDB_DEVICE_DATA where dev_key like ? and dev_id = ?";
	my $sql2 = "select dev_key from NUMDB_DEVICE_DATA where dev_key like ? and dev_id = ?";
	my $sth = $dbh->prepare($sql2);
	$sth->execute("repo%_name",$dev_id);
    $platform_vers =~ s/\s/_/g;
	open(OUTPUT,">$out_dir/$platform_vers.repo") or die "Cannot create $base_dir/playbooks/patching/files/$platform_vers.repo, $! \n";

	while (my $ref = $sth->fetchrow_array()) {
		$ref =~ /\d/;
		my @trow1 = $dbh->selectrow_array($sql,undef,"repo" . "$&"."_name",$dev_id);
		my @trow2 = $dbh->selectrow_array($sql,undef,"repo" . "$&"."_url",$dev_id);
		my ($repo_name) = @trow1;
		my ($repo_url) = @trow2;
		my $repo_id = $repo_name;
		$repo_id =~ s/\s/_/g;
		my $repo_config_rhel = <<RHEL;
[Numisec-$repo_id]
name=$repo_name
enabled=1
baseurl=$repo_url
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck = 1

RHEL

		my $repo_config_suse = <<SUSE;
[Numisec-$repo_id]
name=$repo_name
enabled=1
autorefresh=1
baseurl=$repo_url
type=rpm-md
gpgcheck=0

SUSE


		if ($platform_vers =~ /REDHAT|CENTOS/) {
			print OUTPUT $repo_config_rhel;
		} elsif ($platform_vers =~ /SLES/) {
			print OUTPUT $repo_config_suse;
		} else {
			die "$platform_vers not registered";
		}


	}

	print "$platform_vers.repo" . " created";


}
create_repoconfig("$pv");
$dbh->disconnect();