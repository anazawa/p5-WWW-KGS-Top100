package WWW::KGS::Top100;
use strict;
use warnings;
use URI;
use Web::Scraper;

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    bless \%args, $class;
}

sub base_uri {
    $_[0]->{base_uri} ||= URI->new('http://www.gokgs.com/top100.jsp');
}

sub user_agent {
    $_[0]->{user_agent};
}

sub has_user_agent {
    exists $_[0]->{user_agent};
}

sub parser {
    my $self = shift;
    $self->{parser} ||= $self->_build_parser;
}

sub _build_parser {
    my $self = shift;

    my $parser = scraper {
        process '//table[@class="grid"]//following-sibling::tr', 'players[]' => scraper {
            process '//td[1]', 'position' => 'TEXT';
            process '//td[2]//a', 'name' => 'TEXT';
            process '//td[2]//a', link => '@href';
            process '//td[3]', 'rank' => 'TEXT';
        };
        result 'players';
    };

    $parser->user_agent( $self->user_agent ) if $self->has_user_agent;

    $parser;
}

sub parse {
    my $self = shift;
    my @args = @_ ? @_ : $self->base_uri;
    $self->parser->scrape( @args );
}

1;
