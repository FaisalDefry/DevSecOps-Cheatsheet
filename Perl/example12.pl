#!/usr/bin/env perl

foreach (<>) {
   $_ =~ /Package/  or next ;
   print $_ ;
}