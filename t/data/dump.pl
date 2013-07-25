use strict;
use warnings;
use Data::Dumper;
use WWW::KGS::Top100;

my $html = do { local $/; <> };
my $top100 = WWW::KGS::Top100->new;
my $players = $top100->parse( \$html, $archives->base_uri );

local $Data::Dumper::Terse = 1;
local $Data::Dumper::Indent = 1;

print Dumper( $players );
