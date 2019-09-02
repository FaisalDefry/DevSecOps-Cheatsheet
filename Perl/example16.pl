#!/usr/bin/env perl

use JSON::MaybeXS ;
use Data::Dumper ;

{
local $/; #Enable 'slurp' mode
open(INPUT,"company.json") or die("Cannot open file");
my $company_json = <INPUT> ;
#print Dumper $students_json ;
my $company = decode_json $company_json;
#print Dumper $company;
}
my $employees = $company->{employees};
print Dumper $employees->[0]->{Name} ;
my $boss_hobbies = $company->{boss}->{Hobbies} ;
print "Boss Hobbies: " . join("|",@$boss_hobbies) ;
=pod
foreach $data (@$student) {
    if ($data->{name} eq "$ARGV[0]" ) {
        print $data->{laptop};
        #print "found"
    } 

}
=cut