use strict;
use warnings;

my $file = "mail.lst";
my $output;
open( INPUT, "$file" ) or die "cannot open file $file, $! \n";

foreach $output (<INPUT>) {

    if ( $output =~ /^\S*@\w*\.\w+/ ) {
        print "$& \n";

    }

}
