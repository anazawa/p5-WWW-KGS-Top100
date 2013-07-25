use strict;
use warnings;
use Data::Dumper;
use WWW::KGS::Top100;

my $html = do { local $/; <> };
my $archives = WWW::KGS::Top100->new;
my $result = $archives->parse( \$html, $archives->base_uri );

local $Data::Dumper::Terse = 1;
local $Data::Dumper::Indent = 1;

print Dumper( $result );
