use inc::Module::Install;

all_from 'lib/WWW/KGS/Top100.pm';
readme_from 'lib/WWW/KGS/Top100.pm';

repository 'https://github.com/anazawa/p5-WWW-KGS-Top100';

requires 'Web::Scraper';
requires 'URI';

test_requires 'Test::More' => '0.98';
test_requires 'Path::Class' => '0.22';

tests 't/*.t xt/*.t';

WriteAll;
