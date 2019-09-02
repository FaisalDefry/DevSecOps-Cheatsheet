#!/usr/bin/env perl
use feature say;
my $file = shift;
$|=1;
print "reading:" . $file . "\n";
@rst = ();
if ( -e $file ) {
    open( IN, "< $file" ) or die "Opening " . $file . " $!";
    my $no    = -1;
    my $fetch = 0;
    while ( my $line = <IN> ) {
        chomp $line;
        if ( $line =~ /^-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-/ ) {
            $no++;
        }
        else {
            $rst[$no] .= "\n" . $line;
        }
    }
  #print $rst[1];
    
}

foreach $package  (@rst) {
    
    $package =~ /^name:(.*)/m;
    $name = $1;

    $package =~ /^version:(.*)/m;
    $version = $1;

    $package =~ /^description:(.*)/ms;
    $description = $1;

    say qq("$name","$version","$description");

  #  print $package;

}


