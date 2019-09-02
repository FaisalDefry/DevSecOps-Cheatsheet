#!/usr/bin/perl
use feature say;
open(CMD,"bash text.sh|");
open(OUT,">package.lst");

sub main {
foreach my $info (<CMD>) {
@package=split('\s+', $info);
say OUT "="x40;
say OUT "Package Name: $package[0]";
say OUT "Package Version: $package[1]";

} 
}

main();