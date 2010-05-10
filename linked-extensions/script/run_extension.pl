#!/usr/bin/env perl

use warnings;
use strict;

BEGIN { require "./common.pl"; }

my ($name) = @ARGV;
die "Usage: $0 name" unless defined $name;

assert_ext $name;

-d "$ext_dir/$name" or die "Extension '$name' doesn't exist";
system "eclipse/eclipse -configuration $ext_dir/$name/eclipse/configuration -data $self_dir/ws-admin";

