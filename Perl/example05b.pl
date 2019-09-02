#!/usr/bin/perl


use feature say;
local $/ = qq(=) x 40;
foreach $package (<>) {
    
    $package =~ /Package Name:\s(.*)/;
    $name = $1;


    $package =~ /Package Version:\s(.*)/;
    $version = $1;

    say qq("$name","$version");
    

}
