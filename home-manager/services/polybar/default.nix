{ inputs, lib, config, pkgs, ... }:

let

  modules = builtins.readDir ./modules;

in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = ./config.ini;
    extraConfig = modules;
    script = ''
      polybar top &
    '';
  };
}
