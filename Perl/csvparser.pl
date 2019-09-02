#!/usr/bin/perl
use feature say;
$in_filename = shift;
$out_filename = shift;
open( INPUT, "$in_filename" ) or die("cannot open file $in_filename") ;
open( OUT,   ">$out_filename" );

sub main {
    foreach my $update (<INPUT>) {
        my ( $group, $name, $summary, $description ) = split( ';', $update );
        say OUT "--------------------";
        say OUT "name:$name";
        say OUT "architecture:-";
        say OUT "new_epoch:1";
        say OUT "new_version:-";
        say OUT "new_release:-";
        say OUT "group:$group";
        say OUT "epoch:1";
        say OUT "version:-";
        say OUT "release:-" ;
        say OUT "summary:$summary";
        say OUT "description:$description";
    }
}

main();
