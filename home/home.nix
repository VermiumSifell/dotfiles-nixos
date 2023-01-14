{ config, pkgs, gtk-theme, wallpaper, nix-doom-emacs, ... }:

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

    ## UTILITIES
    git
    qalculate-qt
    speedcrunch
    wireshark
    ripgrep
    wget
    unzip
    direnv
    nixpkgs-fmt
    nmap
    btop
    dunst
    xfce.thunar
    ranger
    protontricks
    networkmanagerapplet
    pavucontrol
    virt-manager
    xclip
    maim
    qbittorrent
    s3cmd
    wireguard-tools
    tmux
    inetutils
    ipcalc
    openssl
    zsh
  ];
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.vermium = {
      programs.home-manager.enable = true;

      imports = [ nix-doom-emacs.hmModule ./programs ./services ];

      gtk = {
        enable = true;
        theme = gtk-theme;
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
            source = ./wm/i3;
            recursive = true;
          };
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      services.picom.enable = true;

      programs.autorandr = {
        enable = true;
        profiles = {
          AxelLaptop01v1 = {
            config = {
              "eDP-1-0" = {
                enable = true;
                mode = "1920x1080";
                primary = true;
                position = "0x0";
                rate = "60.00";
              };
              "HDMI-0" = {
                enable = true;
                mode = "1920x1080";
                position = "1920x0";
                rate = "60.00";
              };
            };
            fingerprint = {
              HDMI-0 =
                "00ffffffffffff004c2d320d484b584305200103803c22782a5295a556549d250e5054bb8c00b30081c0810081809500a9c001010101023a801871382d40582c450056502100001e000000fd0032481e5111000a202020202020000000fc00433237463339300a2020202020000000ff0048344c543130313834390a202001e402031af14690041f131203230907078301000066030c00100080011d00bc52d01e20b828554056502100001e8c0ad090204031200c4055005650210000188c0ad08a20e02d10103e9600565021000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000061";
              eDP-1-0 =
                "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
            };
          };
          AxelLaptop01v2 = {
            config = {
              "eDP-1-0" = {
                enable = true;
                mode = "1920x1080";
                primary = true;
                position = "0x0";
                rate = "60.00";
              };
              "HDMI-0" = { enable = false; };
            };
            fingerprint = {
              eDP-1-0 =
                "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
            };
          };

          AxelLaptop01v3 = {
            config = {
              "eDP-1-0" = {
                enable = true;
                mode = "1920x1080";
                primary = true;
                position = "0x0";
                rate = "60.00";
              };
              "HDMI-0" = {
                enable = true;
                mode = "1680x1050";
                primary = false;
                position = "1920x0";
                rate = "60.00";
              };
            };
            fingerprint = {
              eDP-1-0 =
                "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
              HDMI-0 =
                "00ffffffffffff004c2d1e023032414817100103802b1b782aee95a3544c99260f5054bfef80b30081808140714f010101010101010121399030621a274068b03600b10f1100001c000000fd00384b1e5110000a202020202020000000fc0053796e634d61737465720a2020000000ff004853484c3630313038360a2020004f";
            };
          };

        };
        hooks.postswitch = {
          "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
          "change-dpi" = ''
            case "$AUTORANDR_CURRENT_PROFILE" in
              default)
                DPI=120
                ;;
              home)
                DPI=192
                ;;
              work)
                DPI=144
                ;;
              *)
                echo "Unknown profile: $AUTORANDR_CURRENT_PROFILE"
                exit 1
            esac

            echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
          '';
        };
      };

      programs.doom-emacs = {
        enable = true;
        doomPrivateDir = ./configs/doom;
      };

      services.emacs.enable = true;

      home = {
        inherit username homeDirectory;
        stateVersion = "22.05";

        packages = defaultPkgs;

        file = { ".background-image" = { source = wallpaper; }; };

        sessionVariables = {
          DISPLAY = ":0";
          EDITOR = "nvim";
          DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
          SHELL = "${pkgs.zsh}/bin/zsh";
          MOZ_USE_XINPUT2 = "1";
        };
      };

      # restart services on change
      systemd.user.startServices = "sd-switch";

      # notifications about home-manager news
      news.display = "silent";

      services.gnome-keyring = {
        enable = true;
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      fonts.fontconfig.enable = true;
      programs.git.enable = true;
      programs.zsh.enable = true;
    };
  };
}
