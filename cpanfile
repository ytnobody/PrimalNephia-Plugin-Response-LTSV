requires 'perl', '5.008001';
requires 'Nephia', '0.32';
requires 'Text::LTSV';
requires 'Hash::Flatten';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

