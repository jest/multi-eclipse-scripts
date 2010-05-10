#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;
use vars qw( $self_dir $ext_dir $prog_dir );
$self_dir = "$FindBin::Bin";
$ext_dir = "$self_dir/extensions";
$prog_dir = "$self_dir/programs"; 

sub assert_programs   { -d $prog_dir or die "Can't find programs dir '$prog_dir'" }
sub assert_extensions { -d  $ext_dir or die "Can't find extensions dir '$ext_dir'" }

sub assert_prog { assert_programs;   -d "$prog_dir/$_[0]" or die "Can't find program '$_[0]'" }
sub assert_ext  { assert_extensions; -d  "$ext_dir/$_[0]" or die "Can't find extension '$_[0]'" }

sub assert_no_prog { assert_programs;   -d "$prog_dir/$_[0]" and die "Program '$_[0]' already exists" }
sub assert_no_ext  { assert_extensions; -d  "$ext_dir/$_[0]" and die "Extension '$_[0] already exists" }

1;

