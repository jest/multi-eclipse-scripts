#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;
BEGIN { require "$FindBin::Bin/common.pl"; }

my ($name) = @ARGV;
die "Usage: $0 name" unless defined $name;

assert_no_ext $name;

`mkdir -p $ext_dir/$name/eclipse`;
`echo 'path=$ext_dir/$name' >$ext_dir/$name/self.link`;
`touch $ext_dir/$name/eclipse/.eclipseextension`;

system "perl $FindBin::Bin/run_extension.pl $name";

