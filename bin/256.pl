#! env perl
use Getopt::Long;

my $verbose;
my $reset;

Getopt::Long::Configure ("bundling");
my $result = GetOptions(
  'verbose|v+' => \$verbose,
  'reset|r' => \$reset
);
use YAML;

sub resetTable{
    print "\x1b[0m配色をリセットします\n";
    for ($red = 0; $red < 6; $red++) {
        for ($green = 0; $green < 6; $green++) {
            for ($blue = 0; $blue < 6; $blue++) {
                printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
                    16 + ($red * 36) + ($green * 6) + $blue,
                    int ($red * 42.5),
                    int ($green * 42.5),
                    int ($blue * 42.5));
            }
        }
    }
    for ($gray = 0; $gray < 24; $gray++) {
        $level = ($gray * 10) + 8;
        printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
            232 + $gray, $level, $level, $level);
    }
}

sub showCube{
    my $format = shift;
    for ($color = 0; $color < 16; $color++) {
        printf "\x1b[0m  ";
        printf($format,$color,$color);
        print "\x1b[0m\n" if($color % 8 == 7);
    }
    print "\x1b[0m\n";
    for ($r = 0; $r < 6; $r++) {
        for ($g = 0; $g < 6; $g++) {
            print "\x1b[0m  ";
            for ($b = 0; $b < 6; $b++) {
                $color = 16+$r*6*6+$g*6+$b;
                printf($format,$color,$color);
            }
        }
        print "\n";
    }

    print "\x1b[0m\n";
    for ($color = 232; $color < 256; $color++) {
        print "\x1b[0m  ";
        printf($format,$color,$color);
    }
    print "\x1b[0m\n";
}

sub showCode{
    my $format = "\x1b[0m\t\x1b[48;5;%dm Esc[48;5;%dm ";
    for my $i (0..35)
    {
        printf($format,$i/2,$i/2)      if($i <32);
        print "\x1b[0m\t".(" "x14) unless($i <32);
        $i = $i + 16;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i);
        $i = $i + 36;
        printf($format,$i,$i) if ($i < 256);
        print "\n";
    }
}
sub showAA{
    my $str = shift;
    my $color = shift;
    my $zoom = shift || "1";

    for my $l (split /\n/,$str)
    {
        my @c = split//,$l;
        for(1..$zoom)
        {
            for my $i (0..($#$color))
            {
                printf("\x1b[48;5;%dm ",($c[$i*2]   eq "1")?$color->[$i]:0) for(1..$zoom);
                printf("\x1b[48;5;%dm ",($c[$i*2+1] eq "1")?$color->[$i]:0) for(1..$zoom);
            }
            print "\x1b[0m\n";
        }
    }
}


my $logo = <<EOF
11                                                11
11  1111  1111  1111  1111        11              11
11     1  1     1     1  1  1111  11  1111  1 11  11
11  1111  1111  1111  1     1  1  11  1  1  11    11
11  1        1  1  1  1  1  1  1  11  1  1  1     11
11  1111  1111  1111  1111  1111  11  1111  1     11
11                                                11
EOF
;
my $creeper = <<EOF
  111111111111111111111111
  111111111111111111111111
  111      111111      111
  111      111111      111
  111      111111      111
  111      111111      111
  111111111      111111111
  111111111      111111111
  111111            111111
  111111            111111
  111111            111111
  111111   111111   111111
  111111   111111   111111
  111111111111111111111111
  111111111111111111111111
EOF
;
my @logo_colors = qw/15 0 112 112 0 190 190 0 214 214 0 202 202 0 196 196 0 201 0 93 93 0 21 21 0 15/;
my @creeper_colors = qw/ 0 70 70 70 70 70 70 70 70 70 70 70 70/;
&showAA($logo,\@logo_colors);

print "\x1b[48;5;15m";
print " "x52;
print "\n\n";
&resetTable() if ($reset);
&showCube(($verbose)?"\x1b[48;5;%dm%3d ":"\x1b[48;5;%dm    ") if ( $verbose <=1 );
if ( $verbose == 5)
{
    &showAA($creeper,\@creeper_colors,2);
    exit;
}
&showCode() if ( $verbose > 1 );
