#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

use DBI;
#use DBI qw(:sql_types);
my $user = 'faisal' ;
my $pass = "password" ;
my $dbh = DBI->connect("dbi:mysql:Bands:172.16.1.183",$user,$pass , {RaiseError=>1} ) or die "Cannot connect to database" ;
my @data ;
my @band1 = (1,"MLTR") ;
my @band2 = (2,"Westlife") ;
my @band3 = (3,"BTS") ;
my @band4 = (4,"Oasis") ;

push (@data,\@band1);
push (@data,\@band2);
push (@data,\@band3);
push (@data,\@band4);

my $data_ref = \@data;


sub insert_data {
my $data = shift; 
foreach my $values(@$data) {

    my $id = $values->[0] ;
    my $name = $values->[1]; 
    
    $dbh->do("INSERT INTO Bands VALUES (?, ?) ON DUPLICATE KEY UPDATE name = ?", undef, $id, "$name","$name");
    print "successfully insert data $name \n"
}

}

insert_data($data_ref) ;

# now retrieve data from the table.
my $sth = $dbh->prepare("SELECT * FROM Bands where id = 1");
$sth->execute();

print $sth->fetchrow_hashref()->{name} ;
while (my $ref = $sth->fetchrow_hashref()) {
  print "Found a row: id = $ref->{'id'}, name = $ref->{'name'}\n";
}
$sth->finish();