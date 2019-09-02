#!/usr/bin/perl
use feature say;
open(CMD,"bash text.sh|");
@packages = ("packageA","packageB") ;
%employees = ("Faisal"=> 25, "Sasha" => 20) ;
$a = shift(@packages);
$b = shift(@packages);
say  "="x40;
say  "Package 1: $a";
say  "Package 2: $b";

for (keys %employees) {

say "$_ ages is $employees{$_}" ; 

}

