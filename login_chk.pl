#!/usr/bin/perl
# Program that will check secure file for predefined events

use Term::ANSIColor;
use Getopt::Std;

# Declare command line flags
%flags=();
getopts("l:", \%flags);

$line_pause = $flags{l} if defined $flags{l};
$num = 0;

$datafile = $ARGV[0];

if ( ! -e $datafile )
{
 print "$datafile was not found";
 exit;
}
else
{
 open (DATAFILE, $datafile) or die $!;
 @lines = <DATAFILE>;
}

foreach $line (@lines) {
 if ($line =~ m/Accepted/)
 {
	print color("yellow"), "$line";
	print color("reset");
 }
 elsif ($line =~ m/sudo/) {
	print color("red"), "$line";
	print color("reset");
 }
 else {
	print "$line";
 }
 $num ++;
 if ($num eq $line_pause)
 {
	print color("green"), "*** Press ENTER to continue ***";
	getc();
	$num = 0;
	print color("reset");
 }
}
print color("green"), "**** End of File ****\n";
print color("reset");