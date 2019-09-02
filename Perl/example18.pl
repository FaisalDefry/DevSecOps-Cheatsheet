use HTML::TableExtract ;
use LWP::Simple ;
use Data::Dumper ;
local $/; #Enable 'slurp' mode
open(INPUT,"table-sample.html") or die("Cannot open file");
$html_file =  <INPUT> ;

#print $html_file;
my $te = HTML::TableExtract->new(keep_html=>0);
$te->parse($html_file);
print Dumper $te->tables;
# Examine all matching tables
foreach my $ts ($te->tables) {
  print "Table (", join(',', $ts->coords), "):\n";
  foreach my $row ($ts->rows) {
     print join(',', @$row), "\n";
  }
}

