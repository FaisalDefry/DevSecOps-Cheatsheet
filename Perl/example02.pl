#!/usr/bin/perl

@students = ( "John", "Steve" );
open( DATA, "<ExerciseInputFiles/regex26.txt" )
  or die "Couldn't open file file.txt, $!";
open( DATA2, ">result.txt" );
while (<DATA>) {
    foreach $name (@students) {
        $_ =~ /(\w+)\s(\w+)/;
        print DATA2 "$2,$1", "\n";

    }

}
