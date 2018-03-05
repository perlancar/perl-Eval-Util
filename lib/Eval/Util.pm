package Eval::Util;

# DATE
# VERSION

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(inside_eval);

sub inside_eval {
    my $i = 0;
    while (1) {
        my ($package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext) = #, $is_require, $hints, $bitmask, $hinthash
            caller($i);
        last unless defined $package;
        $i++;
        if ($subroutine eq "(eval)" || $evaltext) {
            return 1;
        }
    };
    0;
}

1;
# ABSTRACT: Utilities related to eval()

=head1 SYNOPSIS

 use Eval::Util qw(inside_eval);

 eval { say "foo" if inside_eval() };
 say "bar" if inside_eval();
 # will print C<foo> but not C<bar>.


=head1 DESCRIPTION


=head1 FUNCTIONS

None exported by default, but they are exportable.

=head2 inside_eval

Usage: inside_eval() => bool

Will check if running code is inside eval() (either string eval or block eval).
This is done via examining the stack trace and checking for frame with
subroutine named C<(eval)>.


=head1 SEE ALSO

C<caller> in L<perlfunc>

=cut
