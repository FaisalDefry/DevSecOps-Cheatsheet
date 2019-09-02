#!/usr/bin/env perl

use JSON ;
use Data::Dumper ;
#my $students_json = '[{"name":"faisal","age":25,"laptop":"macbook"},
#{"name":"sasha","age":22,"laptop":"rog"}]' ;

local $/; #Enable 'slurp' mode
open(INPUT,"pretty.json");
my $students_json = <INPUT> ;
#print Dumper $students_json ;
my $student = decode_json $students_json;
print Dumper $student ;
$student->[2]->{laptop} = razer ;
open(OUTPUT,">output.json");
my $out_json = encode_json $student ;
print OUTPUT $out_json ;
#print Dumper @$student ;
foreach $data (@$student) {
    if ($data->{name} eq "$ARGV[0]" ) {
        print $data->{laptop};
        #print "found"
    } 

}