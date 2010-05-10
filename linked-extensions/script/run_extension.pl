#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;
BEGIN { require "$FindBin::Bin/common.pl"; }

my ($name) = @ARGV;
die "Usage: $0 name" unless defined $name;

assert_ext $name;

system "eclipse/eclipse -configuration $ext_dir/$name/eclipse/configuration -data $self_dir/ws-admin";

