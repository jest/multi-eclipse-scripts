#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;
BEGIN { require "$FindBin::Bin/common.pl"; }

my ($name) = @ARGV;
die "Usage: $0 name" unless defined $name;

assert_no_prog $name;

`mkdir $prog_dir/$name`;
