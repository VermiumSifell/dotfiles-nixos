{ config, lib, pkgs, gtk-theme, wallpaper, nix-doom-emacs, ... }:

let
  username = "vermium";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    ## EDITORS
    vim
    vscodium
    neovim

    ## GAMES
    lutris
    bastet
    minecraft
    prismlauncher

    ## BROWSERS
    qutebrowser
    firefox
    chromium

    ## CHAT
    discord
    signal-desktop
    element-desktop

    ## TERMINALS
    alacritty
    kitty

    ## EMAIL
    thunderbird

    ## MEDIA
    spotify
    vlc
    gimp
    libreoffice
    renoise

    ## SCHOOL
    ciscoPacketTracer8

    ## FONTS
    (pkgs.nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })

    ## DEVELOPMENT
    docker
    docker-compose
    postman
    rnix-lsp
    nixfmt
    direnv
    nixpkgs-fmt

    ## NETWORKING
    (lib.hiPrio traceroute)
    inetutils
    ipcalc
    wireshark
    nmap
    dsniff
    tcpdump
    wireguard-tools

    ## UTILITIES
    qalculate-qt
    speedcrunch
    ripgrep
    wget
    unzip
    zip
    btop
    dunst
    xfce.thunar
    ranger
    networkmanagerapplet
    protontricks
    pavucontrol
    virt-manager
    xclip
    maim
    qbittorrent
    s3cmd
    tmux
    openssl
    thefuck
    neofetch
  ];
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.vermium = {
      programs.home-manager.enable = true;

      imports = [ nix-doom-emacs.hmModule ../programs ../services ];

      gtk = {
        enable = true;
        theme = gtk-theme;

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

        cursorTheme = {
          name = "Numix-Cursor";
          package = pkgs.numix-cursor-theme;
        };

        gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
      };

      qt = {
        enable = true;
        style = {
          name = "adwaita-dark";
          package = pkgs.adwaita-qt;
        };
      };

      xdg = {
        inherit configHome;
        enable = true;

        configFile = {
          "i3" = {
            source = ../wm/i3;
            recursive = true;
          };
          "polybar/launch.sh" = { source = ../configs/polybar/launch.sh; };
        };
      };

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        doom-emacs = {
          enable = true;
          doomPrivateDir = ../configs/doom;
        };
        ssh.enable = true;
      };

      services = {
        picom = {
          enable = true;
          vSync = true;
        };
        flameshot.enable = true;
        emacs.enable = true;
      };

      home = {
        inherit username homeDirectory;
        stateVersion = "22.05";
        packages = defaultPkgs;

        file = { ".background-image" = { source = wallpaper; }; };

        sessionVariables = { MOZ_USE_XINPUT2 = "1"; };
      };

      systemd.user.startServices = "sd-switch";
      news.display = "silent";
      fonts.fontconfig.enable = true;
    };
  };
}
