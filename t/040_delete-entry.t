#!/usr/bin/env perl
use Modern::Perl;
use English qw( -no_match_vars );

use Test::More;
require './t/test-helper.pm';
Test::Helper->import();

use Git;
use File::Temp qw( tempdir );

my $BASE = '.';

my $backup_dir = tempdir( CLEANUP => 1 );
# ----- first backup -----
ok(
    system(
        "$BASE/ldap-git-backup",
        "--ldif-cmd=cat $BASE/t/testdata/data_B1.ldif",
        "--backup-dir=$backup_dir",
    ) == 0,
    'first backup with all entries should run'
);
check_directory_list($backup_dir, qw(
    .
    ..
    .git
    20120604153004Z-3816ac9.ldif
    20120604153004Z-9941228.ldif
    20120604161324Z-7ebb002.ldif
    20120604161334Z-e2a09bd.ldif
    20120608152222Z-92298cf.ldif
    20120608152511Z-e81f2e5.ldif
));

# ----- second backup -----
ok(
    system(
        "$BASE/ldap-git-backup",
        "--ldif-cmd=cat $BASE/t/testdata/data_B2.ldif",
        "--backup-dir=$backup_dir",
    ) == 0,
    'second backup with one fewer entry should run'
);
check_directory_list($backup_dir, qw(
    .
    ..
    .git
    20120604153004Z-3816ac9.ldif
    20120604153004Z-9941228.ldif
    20120604161324Z-7ebb002.ldif
    20120604161334Z-e2a09bd.ldif
    20120608152511Z-e81f2e5.ldif
));

done_testing();
