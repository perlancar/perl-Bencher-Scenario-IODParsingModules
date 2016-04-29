package Bencher::Scenario::IODParsingModules;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use File::ShareDir::Tarball qw(dist_dir);

our $scenario = {
    summary => 'Benchmark IOD/INI parsing modules',
    participants => [
        {
            module => 'Config::IOD::Reader',
            code_template => 'state $iod = Config::IOD::Reader->new; $iod->read_file(<filename>)',
        },
        {
            module => 'Config::IOD',
            code_template => 'state $iod = Config::IOD->new; $iod->read_file(<filename>)',
        },

        {
            module => 'Config::INI::Reader',
            code_template => 'Config::INI::Reader->read_file(<filename>)',
            tags => ['ini'],
        },
        {
            module => 'Config::IniFiles',
            code_template => 'Config::IniFiles->new(-file => <filename>)',
            tags => ['ini'],
        },
        {
            module => 'Config::Simple::Conf',
            code_template => 'Config::Simple::Conf->new(<filename>)',
            tags => ['ini'],
        },
    ],

    datasets => [
    ],
};

my $dir = dist_dir('IOD-Examples')
    or die "Can't find share dir for IOD-Examples";
for my $filename (glob "$dir/examples/extra-bench-*.iod") {
    my $basename = $filename; $basename =~ s!.+/!!;
    push @{ $scenario->{datasets} }, {
        name => $basename,
        args => {filename => $filename},
        ( exclude_participant_tags => ['ini'] ) x ($basename =~ /basic\.iod/ ? 1:0), # these files are not parseable by INI parsers
    };
}

1;
# ABSTRACT:
