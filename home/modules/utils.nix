{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    unzip
    zip
    tmux
    neofetch
    ripgrep
    s3cmd
    openssl
    thefuck
    dunst
    ranger
    pavucontrol
    qbittorrent
    btop
  ];
}
