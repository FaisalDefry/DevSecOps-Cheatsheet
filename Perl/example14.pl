use strict;
use warnings;
use Data::Dumper;

my @array = ("foobar","foolan","barbar","barfoo") ;
@array = grep(/^foo/,@array) ;
print Dumper @array ;