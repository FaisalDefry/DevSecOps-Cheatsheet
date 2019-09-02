#!/usr/bin/env perl
use Data::Dumper;

%dates = (
"sunday" => "minggu",
"saturday" => "sabtu",
"monday" => "senin"
);

#print Dumper $dates{"sunday"} . "\n" ;

while (($key,$value) = each %dates){
    #print $dates{$_} . "\n";
    print "$key : $value" . "\n";

} 