use strict;
use warnings;

use Data::Dumper;

$|=1;

sub main {
	
	my $input = 'debt.csv';
	
	unless(open(INPUT, $input)) {
		die "\nCannot open $input\n";
	}
	
	<INPUT>;
	
	my @lines;

	while(my $line = <INPUT>) {
		
		chomp $line;
		
		
		my @values = split /\s*,\s*/, $line;

		
		push @lines, \@values;
	}
	
	close INPUT;
	
	
	print $lines[3][1] . "\n";
	
	foreach my $line(@lines) {
		print Dumper($line);
		
		print "Name " . $line->[0] . "\n";
	}
}

main();

