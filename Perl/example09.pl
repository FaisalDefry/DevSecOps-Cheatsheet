#!/usr/bin/env perl
use Data::Dumper;
use strict;
use warnings;
use feature "say";

#use 5.012 ;

open( INPUT, "debt.csv" );
<INPUT>;
my @debt_list;
my @lines;
LINE: while ( my $line = <INPUT> ) {
    $line =~ /\S+/
      or print STDERR "line $. is empty. Skipping.... \n" and next LINE;
    chomp($line);
    my @values = split( ',', $line );

    #Make sure array have 3 variables
    if ( @values < 3 ) {
        print STDERR "line $. have incomplete data. Skipping.... \n";
        next LINE;
    }
    my ( $name, $payment, $date ) = @values;
    $date =~ /^\d+$/
      or print STDERR "line $. Date must be numeric format. Skipping.... \n"
      and next LINE;
    push @lines, \@values;
}

#print 'print Dumper @lines;' . "\n" ;
#print Dumper @lines;

foreach my $line (@lines) {

    #my @line = @$_;
    #print Dumper @line ;
    #print Dumper @$line[0] . "\n";
    #say Dumper @$line   ;
    my %data;
    %data = (
    "name"=>"@$line[0]",
    "amount"=>"@$line[1]",
    "date"=>"@$line[2]"
    );
    #$data{name}   = @$line[0];
    #$data{amount} = @$line[1];
    #$data{date}   = @$line[2];
    push @debt_list, \%data;
}

say Dumper  @debt_list;

my $total_debt = 0;
foreach my $item (@debt_list) {
    print $item->{name} . "\n";
    $total_debt += $item->{amount} ;
}

print "Total Debt :" . $total_debt ;