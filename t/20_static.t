use strict;
use warnings;
use Path::Class qw/dir/;
use Test::More;
use WWW::KGS::Top100;

my @tests;
for my $dir ( dir('t/data')->children ) {
    next unless $dir->is_dir;
    push @tests, {
        name => $dir->basename,
        input => scalar $dir->file('input.html')->slurp(iomode=>'<:encoding(UTF-8)'),
        expected => do $dir->file('expected.pl'),
    };
}

plan tests => scalar @tests;

my $top100 = WWW::KGS::Top100->new;

for my $test ( @tests ) {
    my $got = $top100->parse( \$test->{input}, $top100->base_uri );
    is_deeply $got, $test->{expected}, $test->{name};
}
