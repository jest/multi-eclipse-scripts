#!/usr/bin/env perl

use warnings;
use strict;

BEGIN { require "./common.pl"; }

my ($name) = @ARGV;
die "Usage: $0 name" unless defined $name;

assert_prog $name;

system "eclipse/eclipse -configuration $prog_dir/$name/eclipse/configuration";

