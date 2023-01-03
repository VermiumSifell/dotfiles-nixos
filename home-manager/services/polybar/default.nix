{ inputs, lib, config, pkgs, ... }:

let

  battery = builtins.readFile ./modules/battery.ini;
  bspwm = builtins.readFile ./modules/bspwm.ini;
  cpu = builtins.readFile ./modules/cpu.ini;
  date = builtins.readFile ./modules/date.ini;
  eth = builtins.readFile ./modules/eth.ini;
  filesystem = builtins.readFile ./modules/filesystem.ini;
  i3 = builtins.readFile ./modules/i3.ini;
  memory = builtins.readFile ./modules/memory.ini;
  network-base = builtins.readFile ./modules/network-base.ini;
  pulseaudio = builtins.readFile ./modules/pulseaudio.ini;
  wlan = builtins.readFile ./modules/wlan.ini;
  xkeyboard = builtins.readFile ./modules/xkeyboard.ini;
  xwindow = builtins.readFile ./modules/xwindow.ini;
  xworkspaces = builtins.readFile ./modules/xworkspaces.ini;

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
    extraConfig =
      battery +
      bspwm +
      cpu +
      date +
      eth +
      filesystem +
      i3 +
      memory +
      network-base +
      pulseaudio +
      wlan +
      xkeyboard +
      xwindow +
      xworkspaces;
    script = ''
      polybar top &
    '';
  };
}
