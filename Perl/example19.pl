#!/usr/bin/perl
use warnings;
use strict;
use URI;
use Web::Scraper;
use Data::Dumper;
 
open FILE, ">file.txt" or die $!;
 
# website to scrape
my $urlToScrape = "file:///Users/faisaldefry/Library/CloudStorage/iCloud%20Drive/Documents/Material%20Training/Perl/table-sample.html";
 
# prepare data
my $teamsdata = scraper {
 # we will save the urls from the teams
 #process "table#UCITeamList > tr > td > a", 'urls[]' => '@href';
 # we will save the team names
 process "table#table-example > tr ", 'contact[]' => 'TEXT';
};
# scrape the data
my $res = $teamsdata->scrape(URI->new($urlToScrape));
 
 print Dumper $res->{contact} ;
# print the second field (the teamname)
for my $i (0 .. $#{$res->{contact}}) {
 if ($i%3 != 0 && $i%3 != 2) {
 #print $res->{contact}[$i];
 #print "\n";
 print  FILE $res->{contact}[$i];
 print FILE "\n";
 }
}