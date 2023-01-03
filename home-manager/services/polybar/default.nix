{ inputs, lib, config, pkgs, ... }:

let


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
    extraConfig = [
      ./modules/battery.ini
      ./modules/bspwm.ini
      ./modules/cpu.ini
      ./modules/date.ini
      ./modules/eth.ini
      ./modules/filesystem.ini
      ./modules/i3.ini
      ./modules/memory.ini
      ./modules/network-base.ini
      ./modules/pulseaudio.ini
      ./modules/wlan.ini
      ./modules/xkeyboard.ini
      ./modules/xwindow.ini
      ./modules/xworkspaces.ini
    ];
    script = ''
      polybar top &
    '';
  };
}
