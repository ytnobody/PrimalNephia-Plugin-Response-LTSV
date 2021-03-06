package PrimalNephia::Plugin::Response::LTSV;
use 5.008005;
use strict;
use warnings;
use Text::LTSV;
use Hash::Flatten ();

our $VERSION = "0.01";
our @EXPORT = qw/ltsv_res/;

sub ltsv_res ($) {
    my $value = shift;
    my $content = ref($value) eq 'HASH' ? Text::LTSV->new(%{_preprocess_hash($value)})->to_s :
                  ref($value) eq 'ARRAY' ? join( "\n", map { Text::LTSV->new(%{_preprocess_hash($_)})->to_s } @$value) :
                  undef
    ;
    return [
        200, ['Content-Type' => 'text/x-ltsv; charset=UTF-8'], [ $content ]
    ];
}

sub _preprocess_hash {
    my $hash = shift;
    my $flatten = Hash::Flatten::flatten($hash);
    return +{map {($_ => $flatten->{$_})} sort keys %$flatten};
}

1;
__END__

=encoding utf-8

=head1 NAME

PrimalNephia::Plugin::Response::LTSV - A plugin for PrimalNephia that give LTSV responding feature

=head1 SYNOPSIS

    package YourApp;
    use PrimalNephia plugins => ['Response::LTSV'];
    path '/' => sub {
        return ltsv_res [
            +{ name => 'ytnobody', age => '32' },
            +{ name => 'tonkichi', age => '27' },
            ...
        ];
    };

=head1 DESCRIPTION

Labeled Tab-separated Values (LTSV) format is a variant of Tab-separated Values (TSV). 

PrimalNephia::Plugin::Response::LTSV gives responding feature with in LTSV format.

=head1 EXPORTS

=head2 ltsv_res $HASHREF_OR_ARRAYREF

Returns PSGI-response that contains LTSV formatted contents.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<Text::LTSV>

L<Hash::Flatten>

L<http://ltsv.org/>

=cut

