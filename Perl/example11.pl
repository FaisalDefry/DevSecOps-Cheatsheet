#!/usr/bin/perl
#use strict;
use warnings;
#use v5.10.0;
use feature "say";
use Data::Dumper;

$| = 1;

sub main {


	my %hash1 = (
		"faisal" => "meat",
		"birds" => "seeds",
		"fish" => "worms",
	);
	
    	my %hash2 = (
		"faisal" => "sate",
		"sasha" => "sushi",
		"mocha" => "ayam",
	);

	my @test;

	# We could push a reference to a hash onto an array.
	push @test, \%hash1;
    push @test, \%hash2;
	
	# We could also just refer to the element after the end of the array
	# and by setting it, create it:
	#$test[1] = \%hash1;
	my $line ;
	foreach $line (@test) {
         #my %line = %$_;
         #say Dumper $line{faisal};
        say Dumper (%$line);
    }
	#print $test[0]{"birds"} . "\n";
	#print $test[1]{"faisal"} . "\n";
}

main();

