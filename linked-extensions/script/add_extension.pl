#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;
BEGIN { require "$FindBin::Bin/common.pl"; }

my ($name, $ext_name) = @ARGV;
die "Usage: $0 name ext_name" unless defined $name && defined $ext_name;

assert_ext $name;
assert_ext $ext_name;

`mkdir -p $ext_dir/$name/eclipse/dropins`;
`cp $ext_dir/$ext_name/self.link $ext_dir/$name/eclipse/dropins/$ext_name.link`;

