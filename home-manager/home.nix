{ config, lib, pkgs, stdenv, ... }:

let
  username = "vermium";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    discord # All-in-one cross-platform voice and text chat for gamers
    firefox # A web browser built from Firefox source tree
    thunderbird # A full-featured e-mail client
    git # Distributed version control system
    ciscoPacketTracer8 # Network simulation tool from Cisco
    docker # An open source project to pack, ship and run any application as a lightweight container
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    alacritty # A cross-platform, GPU-accelerated terminal emulator
    dunst # Lightweight and customizable notification daemon
    signal-desktop # Private, simple, and secure messenger
    emacs # The extensible, customizable GNU text editor
    qalculate-qt # The ultimate desktop calculator
    xfce.thunar # Xfce file manager
    vscodium # Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
    prismlauncher # A free, open source launcher for Minecraft
    minecraft # Official launcher for Minecraft, a sandbox-building game
    element-desktop # A feature-rich client for Matrix.org
    postman # API Development Environment
    qutebrowser # Keyboard-focused browser with a minimal GUI
    gimp # The GNU Image Manipulation Program
    bastet # Tetris clone with 'bastard' block-choosing AI
    chromium # An open source web browser from Google
    wireshark # Powerful network protocol analyzer
    btop # A monitor of resources
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    neovim # Vim text editor fork focused on extensibility and agility
    ranger # File manager with minimalistic curses interface
    rofi # Window switcher, run dialog and dmenu replacement
    spotify # Play music from the Spotify music service
    vim # The most popular clone of the VI editor
    speedcrunch # A fast power user calculator
    vlc # Cross-platform media player and streaming server
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })

    nixpkgs-fmt
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
