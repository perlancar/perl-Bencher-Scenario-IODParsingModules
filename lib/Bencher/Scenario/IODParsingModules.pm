package Bencher::Scenario::IODParsingModules;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use File::ShareDir::Tarball qw(dist_dir);

our $scenario = {
    summary => 'Benchmark IOD parsing modules',
    participants => [
        {
            module => 'Config::IOD::Reader',
            code_template => 'state $iod = Config::IOD::Reader->new; $iod->read_file(<filename>)',
        },
        {
            module => 'Config::IOD',
            code_template => 'state $iod = Config::IOD->new; $iod->read_file(<filename>)',
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
    };
}

1;
# ABSTRACT:

=head1 SYNOPSIS

 % bencher -m IODParsingModules [other options]...


=head1 SEE ALSO
