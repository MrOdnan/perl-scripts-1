#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 02 October 2015
# Website: https://github.com/trizen

# A simple program which plays the Reflex Sheep game by itself.
# See: https://youtu.be/FrYFE4m8jc0

use strict;
use warnings;

use GD;
use Time::HiRes qw(sleep);

my $count = 0;

ROOT: while (1) {
    my $gd = GD::Image->new(scalar `maim --x=640 --y=150 -w 10 -h 850 --format=jpg /dev/stdout`);
    my ($width, $height) = $gd->getBounds;

  OUTER: foreach my $y (0 .. $height - 1) {
        foreach my $x (0 .. $width - 1) {
            my $pixel = $gd->getPixel(0, $y);
            my ($r, $g, $b) = $gd->rgb($pixel);
            my $avg = ($r + $g + $b) / 3;
            if ($avg < 50) {
                sleep(0.07);    # let the ship to run a little bit more
                system("xdotool", "click", "1");
                sleep(1);       # sleep a little bit after clicking
                ++$count == 5 ? last ROOT: last OUTER;
            }
        }
    }
}
