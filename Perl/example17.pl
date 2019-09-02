use LWP::Simple ;
use HTML::TableExtract ;
use Data::Dumper ;


local $/; #Enable 'slurp' mode
my $url = "https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=94debd3d-b7b7-42e0-9645-11a4e8c83772" ;
$html_file = get($url);
#open(INPUT,"/tmp/example.html") or die("Cannot open file");

#$html_file =  <INPUT> ;
#print Dumper $html_file;
$table_extract = HTML::TableExtract->new(keep_html=>0);
$table_extract->parse("$html_file");
#print Dumper $table_extract->tables ;
$table = $table_extract->tables ;
#print Dumper $table->rows;
  foreach $ts ($table_extract->tables) {
    #print "Table (", join(',', $ts->coords), "):\n";
    foreach my $row ($ts->rows) {
        print Dumper $ts->coords;
      #print join(',', @$row), "\n";
      if (join(',', $ts->coords) eq "0,1") {
        #print Dumper($ts->rows);
        #print $ts->rows->[0][0]."\n";
        if ($ts->rows->[0][0] =~ m/Description\:(.+?)Architecture\:/msg) {
          $des = $1;
          chomp $des;
          $des =~ s/^\s+//;
          $des =~ s/\s+$//;
          $des = $des." more information : http://support.microsoft.com/help/".$kb;
        }
        if ($ts->rows->[0][0] =~ m/Architecture\:(.+?)Classification\:/msg) {
          $raw = $1;
          chomp $raw;
          $raw =~ s/^\s+//;
          $raw =~ s/\s+$//;
          @raw1 = split(m/\s+\,\s+/mgs,$raw);
          $raw2 = join(',',@raw1);
          $arc = $raw2;
        }
        if ($ts->rows->[0][0] =~ m/Classification\:(.+?)Supported\s+products\:/msg) {
          $grp = $1;
          chomp $grp;
          $grp =~ s/^\s+//;
          $grp =~ s/\s+$//;
        }
      }
    }
  }

