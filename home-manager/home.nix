{ config, lib, pkgs, stdenv, ... }: {
  imports = [
    ./gnupg.nix
    ./polybar.nix
    ./alacritty.nix
  ];

  home = {
    username = "vermium";
    homeDirectory = "/home/vermium";
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
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

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  services.dunst.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
