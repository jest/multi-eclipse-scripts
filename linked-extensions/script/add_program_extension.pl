#!/usr/bin/env perl

use warnings;
use strict;

BEGIN { require "./common.pl"; }

my ($name, $ext_name) = @ARGV;
die "Usage: $0 name ext_name" unless defined $name && defined $ext_name;

assert_prog $name;
assert_ext  $ext_name;

`mkdir -p $prog_dir/$name/eclipse/dropins`;
`cp $ext_dir/$ext_name/self.link $prog_dir/$name/eclipse/dropins/$ext_name.link`;

