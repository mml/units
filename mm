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

if ($ARGV[0] =~ /\./) {
  my $inch = shift;
  printf "%s\" = %.fmm\n", $inch, $inch*25.4;
} else {
  my $mm = shift;
  my $eighths = sprintf '%.f', $mm / 3.175;
  my $inch = $eighths / 8;
  $eighths = $eighths % 8;
  my $ft = $inch / 12;
  my $rin = $inch % 12;

  printf "%dmm = %d%s\" = %d$prime-%2d%s$dprime\n", $mm, $inch, $fraction{$eighths}, $ft, $rin, $vulgar{$eighths};
}
