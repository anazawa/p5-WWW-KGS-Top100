use strict;
use warnings;
use WWW::KGS::Top100;
use Test::More tests => 5;

my $top100 = WWW::KGS::Top100->new;

isa_ok $top100, 'WWW::KGS::Top100';

can_ok $top100, qw(
    user_agent
    has_user_agent
    base_uri
    parser
    _build_parser
    parse
);

isa_ok $top100->parser, 'Web::Scraper';

isa_ok $top100->base_uri, 'URI';
is $top100->base_uri->as_string, 'http://www.gokgs.com/top100.jsp';

