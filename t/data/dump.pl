use strict;
use warnings;
use Data::Dumper;
use WWW::KGS::Top100;

my $html = do { local $/; <> };
my $top100 = WWW::KGS::Top100->new;
my $result = $top100->parse( \$html, $top100->base_uri );

local $Data::Dumper::Terse = 1;
local $Data::Dumper::Indent = 1;

print Dumper( $result );
