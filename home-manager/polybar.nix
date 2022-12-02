{ config, pkgs, ... }:

let
  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

in
{
  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ''
[bar/main]
width = 100%
height = 48
radius = 6.0
fixed-center = true
'';
    script = ''
polybar main &
'';
  };
}
