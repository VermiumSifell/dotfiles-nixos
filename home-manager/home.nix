{ config, lib, pkgs, stdenv, ... }:

let
  username = "vermium";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    discord
    spotify
    firefox
    thunderbird
    git
    steam
    ciscoPacketTracer8
    docker
    docker-compose
    alacritty
    dunst
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
    ./services
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "22.05";

    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";


  fonts.fontconfig.enable = true;
  programs.git.enable = true;
  services.dunst.enable = true;

}




#  imports = [
#    ./gnupg.nix
#    ./polybar.nix
#    ./alacritty.nix
#  ];
