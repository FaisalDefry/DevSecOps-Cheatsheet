#!/usr/bin/perl
use feature say;
local $/ = qq(=) x 40;
foreach (<>) {

    #if (/(Package Name:.*)/) {
    if (/Package Name:\s(.*)/) {
        $name = $&;

    }
    
    #if (/(Package Version:.*)/) {
    if (/Package Version:\s(.*)/) {

        
        $version = $&;
    }

    say qq($name | $version);

}
