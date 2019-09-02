
#!/usr/bin/env perl

use strict;
use warnings;
use LWP::Simple;
use Data::Dumper;
use Getopt::Std;
use feature "say";
my %opts;
getopts( 't:sh', \%opts );
my $target   = $opts{t};
my $security = $opts{s};
my $category;

if ( defined($security) ) {
    $category = "Security Update";
}

unless ( !defined( $opts{h} ) ) {
    usage();
}
elsif ( !defined($target) ) {
    usage();
    die("Please specify target url \n");
}

sub usage {
    my $help = <<USAGE;
     Usage: $0 -t <target url> [-s]
    
     Options:
        -t Target
        -s Only display security updates

USAGE
    die("$help")
}

#my $url = "https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=94debd3d-b7b7-42e0-9645-11a4e8c83772" ;

sub get_updates {
    my $url      = shift;
    my $category = shift;
    my $content  = get("$url");
    unless ( defined($content) ) {
        die("cannot open url");
    }

    my $type;

    #$content =~ m`<span id="ScopedViewHandler_desc">(.*)</span>` ;
    #print Dumper $content ;
    #$content =~ m|<div style="padding-bottom: 0.3em;">.+?</div>|msg ;
    #print $& ;
    #print "Description: " . $1;

    my @updates = $content =~
m|<div style="padding-bottom: 0.3em;">\s*(.+$category.+KB\d+\))\s*</div>|mg;
    return @updates;
}

#print Dumper @updates ;
#say Dumper get_updates($target,$category) ;
#foreach ( get_updates($target,$category)) {

sub main {
    my $iteration_number = 0;
    my @KB               = get_updates( $target, $category );
    foreach (@KB) {
        $iteration_number++;

        #print "$iteration_number." . $_ . "\n" ;
    }
}

#usage ;
#while ($content =~ m|<div style="padding-bottom: 0.3em;">\s*(.+KB\d+\))\s*</div>|mg) {
#print "line:" . $1 . "\n" ;

#}
