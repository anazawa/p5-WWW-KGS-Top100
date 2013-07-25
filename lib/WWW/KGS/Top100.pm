package WWW::KGS::Top100;
use 5.008_009;
use strict;
use warnings;
use URI;
use Web::Scraper;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    bless \%args, $class;
}

sub players {
    my $class = shift;
    $class->new->parse(@_);
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
            process '//td[2]//a', 'link' => '@href';
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

__END__

=head1 NAME

WWW::KGS::Top100 - Top 100 KGS Players

=head1 SYNOPSIS

  use WWW::KGS::Top100;
  my $players = WWW::KGS::Top100->players;

=head1 DESCRIPTION

=head2 CLASS METHODS

=over 4

=item $top100 = WWW::KGS::Top100->new

Creates a C<WWW::KGS::Top100> object. The possible parameters are:

=over 4

=item base_uri

Defaults to C<http://www.gokgs.com/top100.jsp>.

=item user_agent

This parameter is used to construct a L<Web::Scraper> object.

=back

=item $players = WWW::KGS::Top100->players

A shortcut for:

  my $players = WWW::KGS::Top100->new->parse;

=back

=head2 INSTANCE METHODS

=over 4

=item $players = $top100->parse

Returns an array reference of hash references which represents the top 100
KGS players.

  my $players = $top100->parse;
  # => [
  #     {
  #         position => 1,
  #         name     => 'foo',
  #         rank     => '9d',
  #         link     => 'http://www.gokgs.com/graphPage.jsp?user=foo',
  #     },
  #     {
  #         position => 2,
  #         name     => 'bar',
  #         rank     => '9d',
  #         link     => 'http://www.gokgs.com/graphPage.jsp?user=bar',
  #     },
  #     ...
  #     {
  #         position => 100,
  #         name     => 'baz',
  #         rank     => '6d',
  #         link     => 'http://www.gokgs.com/graphPage.jsp?user=baz',
  #     },
  # ]

=back

=head1 SEE ALSO

L<WWW::KGS::GameArchives>

=head1 AUTHOR

Ryo Anazawa (anazawa@cpan.org)

=head1 LICENSE

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
