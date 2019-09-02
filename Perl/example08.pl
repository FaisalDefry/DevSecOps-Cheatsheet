#!/usr/bin/env perl
use Data::Dumper;
#use strict;
use warnings;
$|=1;


my @animals = ("dog","cat","bird","lion","girrafe","snake") ;
my @plants = ("rose","lily","jasmine","sunflower") ;
print Dumper @animals;
my @creatures = (\@animals,\@plants);
my $creatures_ref = \@creatures ;
print Dumper @creatures;
foreach my $values (@$creatures_ref ) {
    print "Ini : \n";
    print Dumper $values . "\n" ;
}

