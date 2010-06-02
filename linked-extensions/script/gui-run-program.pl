#!/usr/bin/env perl

use warnings;
use strict;

use 5.010;

use UI::Dialog;
use Readonly;

Readonly my $prog_dir => 'programs/';

my @programs = map { s|^$prog_dir/*||; $_ } <$prog_dir/*>;

my $d = UI::Dialog->new;
my $selection = $d->menu(
	text    => 'Select Eclipse program to run',
	list    => [ sort @programs ],
	columns => [ 'Program' ]
);
if ($selection) {
	my $cmd = "perl script/run_program.pl $selection";
	`$cmd`;
}

#jedit :tabSize=4:indentSize=4:

