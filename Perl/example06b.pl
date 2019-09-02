#!/usr/bin/perl


use feature say;
local $/ = "--------------------";
@packages = <> ;


foreach $package (@packages) {
    
    $package =~ m/^name:(.*)/mg;
    $name = $1;


    $package =~ m/^version:(.*)/mg;
    $version = $1;

    $package =~ m/^description:(.*)/msg;
    $description = $1;
    $description =~ s/(.*)\n--------------------/$1/g ;


    say qq("$name","$version","$description");

  #  print $package;

}
