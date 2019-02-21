#!/usr/bin/perl

use warnings;
use strict;

binmode STDOUT, ':utf8';

our %vulgar = (
  0 => ' ',
  1 => "\x{215b}",
  2 => "\x{00bc}",
  3 => "\x{215c}",
  4 => "\x{00bd}",
  5 => "\x{215d}",
  6 => "\x{00be}",
  7 => "\x{215e}",
);

our $prime = "\x{2032}";
our $dprime = "\x{2033}";


our %fraction = (
  0 => '',
  1 => ' 1/8',
  2 => ' 1/4',
  3 => ' 3/8',
  4 => ' 1/2',
  5 => ' 5/8',
  6 => ' 3/4',
  7 => ' 7/8',
);

sub inch($) {
  my $inch = shift;
  printf "%s\" = %.fmm\n", $inch, $inch*25.4;
}

# Three ways to specify inches.
# decimal:              1.875	0.5	1.0
# fraction:             15/8	1/2	1/1 (<-- a stretch)
# mixed fraction:	1-7/8	0-1/2	1-
if ($ARGV[0] =~ /\./) {
  inch $ARGV[0];
} elsif ($ARGV[0] =~ m{^(\d+)/(\d+)$}) {
  inch $1 / $2;
} elsif ($ARGV[0] =~ m{^(\d+)-(?:(\d+)/(\d+))?$}) {
  if (defined $2) {
    inch $1 + $2 / $3;
  } else {
    inch $1;
  }
} else {
  my $mm = shift;
  my $eighths = sprintf '%.f', $mm / 3.175;
  my $inch = $eighths / 8;
  $eighths = $eighths % 8;
  my $ft = $inch / 12;
  my $rin = $inch % 12;

  printf "%dmm = %d%s\" = %d$prime-%2d%s$dprime\n", $mm, $inch, $fraction{$eighths}, $ft, $rin, $vulgar{$eighths};
}
