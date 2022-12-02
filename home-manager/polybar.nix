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
  };
}
