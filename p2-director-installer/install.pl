#!/usr/bin/perl

use warnings;
use strict;
use subs qw( print_usage );
use YAML ( );

my $BUILDDIR='/home/jest/miszmasz/p2-director/builder';
my $DESTSDIR='/home/jest/miszmasz/p2-director/dest';
my $POOLDIR='/home/jest/miszmasz/p2-director/pool';

my %cmd_templates = (
	install => <<'_EOT_',
java -jar $BUILDDIR/plugins/org.eclipse.equinox.launcher_*.jar
   -application org.eclipse.equinox.p2.director
   -metadataRepository $metadata_url
   -artifactRepository $artifacts_url
   -installIU $iu
   -destination $DESTSDIR/$dest
   -profile $profile
   -profileProperties org.eclipse.update.install.features=true
   -bundlepool $POOLDIR
   -p2.os linux
   -p2.ws gtk
   -p2.arch x86
   -nosplash
   -consoleLog
   -vmargs
   -Declipse.p2.data.area=$DESTSDIR/$dest/p2
_EOT_

	add => <<'_EOT_',
java -jar $BUILDDIR/plugins/org.eclipse.equinox.launcher_*.jar
   -application org.eclipse.equinox.p2.director
   -metadataRepository $metadata_url
   -artifactRepository $artifacts_url
   -installIU $iu
   -destination $DESTSDIR/$dest
   -nosplash
   -consoleLog
_EOT_

);


my $conf = YAML::LoadFile 'config';
run(@ARGV);
exit 0;


sub run {

	my ($txtcmd, $name, $version, $dest) = @_;
	print_usage and die unless defined $dest;
	
	my $pkgconf = $conf->{packages}{$name};
	unless ($pkgconf) {
		print STDERR "Unknown package.\n";
		print_usage and exit 1;
	}
	
	if ($pkgconf->{depends}) {
		for my $p (@{$pkgconf->{depends}{install}}) {
			run('install', $p, $version, $dest);
		}
		for my $p (@{$pkgconf->{depends}{add}}) {
			run('add', $p, $version, $dest);
		}
	} else {
		install_package($txtcmd, $pkgconf, $version, $dest);
	}
}

sub install_package {
	my ($txtcmd, $pkgconf, $version, $dest) = @_;
	
	my $iu = $pkgconf->{iu};
	die "Missing IU" unless $iu;
	
	my $profile = $pkgconf->{profile};
	die "The package didn't specified profile and can't be installed; try 'add' instead"
		if $txtcmd eq 'install' && !$profile;
	
	my $metadata_url = $conf->{versions}{$version}{metadata};
	my $artifacts_url = $conf->{versions}{$version}{artifacts};
	
	if (exists $pkgconf->{metadata}) {
		print "Overriding version 'metadata' with package specific value\n";
		$metadata_url = $pkgconf->{metadata};
	}
	if (exists $pkgconf->{artifacts}) {
		print "Overriding version 'artifacts' with package specific value\n";
		$artifacts_url = $pkgconf->{artifacts};
	}
	
	my $cmd_tmpl = $cmd_templates{$txtcmd};
	unless ($cmd_tmpl) {
		print STDERR "Unknown action.\n";
		print_usage and exit 1;
	}
	my $cmd = eval qq("$cmd_tmpl");
	print "Error: ", $@ and exit 1 if $@;
	print "=== Running: ", $cmd, "\n";
	
	$cmd =~ s/\n/ /mg;
	system $cmd;
}

sub print_usage {
	my $cmds = join ' | ', keys %cmd_templates, 'help';
	print STDERR "Usage: perl $0 [$cmds] name version destination\n";
	
	my $pkgs_txt = join "\n  ", sort keys %{$conf->{packages}};
	printf STDERR "Known packages are:\n  %s\n", $pkgs_txt;
}

# jedit :mode=perl:

