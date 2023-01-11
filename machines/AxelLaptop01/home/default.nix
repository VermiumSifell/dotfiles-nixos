{ config, pkgs, firefox-addons, ... }:
let
  username = "vermium";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  gtk-theme = {
    name = "Materia-dark";
    package = pkgs.materia-theme;
  };

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
    #    rofi # Window switcher, run dialog and dmenu replacement
    spotify # Play music from the Spotify music service
    vim # The most popular clone of the VI editor
    speedcrunch # A fast power user calculator
    vlc # Cross-platform media player and streaming server
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; }) # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    nixpkgs-fmt # Nix code formatter for nixpkgs
    nmap # A free and open source utility for network discovery and security auditing
    networkmanagerapplet
    wget
    pavucontrol
    lutris
    ripgrep
    unzip
    virt-manager
    xclip
    maim
    qbittorrent
    s3cmd
    wireguard-tools
    tmux
    inetutils
    ipcalc
    # rofi-emoji
    # rofi-calc
    protontricks
    openssl
    direnv
  ];
in
{
  home-manager.users.vermium = {

    programs.home-manager.enable = true;

    # imports = builtins.concatMap import [
    #   ./programs
    #   ./services
    # ];


    programs.firefox = {
      enable = true;
      extensions = [
        firefox-addons.packages.x86_64-linux.bitwarden
        firefox-addons.packages.x86_64-linux.ublock-origin
        firefox-addons.packages.x86_64-linux.kristofferhagen-nord-theme
      ];
      profiles = {
        default = {
          isDefault = true;
          settings = {
            # Do not save passwords to Firefox...
            "security.ask_for_password" = false;

            # We handle this elsewhere
            "browser.shell.checkDefaultBrowser" = false;

            # Don't allow websites to prevent use of right-click, or otherwise
            # messing with the context menu.
            "dom.event.contextmenu.enabled" = true;

            # Don't allow websites to prevent copy and paste. Disable
            # notifications of copy, paste, or cut functions. Stop webpage
            # knowing which part of the page had been selected.
            "dom.event.clipboardevents.enabled" = true;

            # Do not track from battery status.
            "dom.battery.enabled" = false;

            # Show punycode. Help protect from character 'spoofing'.
            "network.IDN_show_punycode" = true;

            # Disable site reading installed plugins.
            "plugins.enumerable_names" = "";

            # Enable auto scrolling.
            "general.autoScroll" = true;

            # Remove those extra empty spaces in both sides
            "browser.uiCustomization.state" = ''
              {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","downloads-button","fxa-toolbar-menu-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar"],"currentVersion":17,"newElementCount":4}
            '';
          };
        };
      };
    };




    xdg = {
      inherit configHome;
      enable = true;

      configFile = {
        "i3" = {
          source = ./configs/i3;
          recursive = true;
        };
        # "rofi" = {
        #   source = ./configs/rofi;
        #   recursive = true;
        # };
        # "dunst" = {
        #   source = ./configs/dunst;
        #   recursive = true;
        # };
      };
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    gtk = {
      enable = true;
      theme = gtk-theme;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    };
    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
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
            HDMI-0 = "00ffffffffffff004c2d320d484b584305200103803c22782a5295a556549d250e5054bb8c00b30081c0810081809500a9c001010101023a801871382d40582c450056502100001e000000fd0032481e5111000a202020202020000000fc00433237463339300a2020202020000000ff0048344c543130313834390a202001e402031af14690041f131203230907078301000066030c00100080011d00bc52d01e20b828554056502100001e8c0ad090204031200c4055005650210000188c0ad08a20e02d10103e9600565021000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000061";
            eDP-1-0 = "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
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
            "HDMI-0" = {
              enable = false;
            };
          };
          fingerprint = {
            eDP-1-0 = "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
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
            eDP-1-0 = "00ffffffffffff0030e42e0600000000001d0104952213780338d5975e598e271c505400000001010101010101010101010101010101243680a070381f403020350058c210000019182480a070381f403020350058c21000001900000000000000000000000000000000000000000002000c3aff0a3c7d1314267d000000002f";
            HDMI-0 = "00ffffffffffff004c2d1e023032414817100103802b1b782aee95a3544c99260f5054bfef80b30081808140714f010101010101010121399030621a274068b03600b10f1100001c000000fd00384b1e5110000a202020202020000000fc0053796e634d61737465720a2020000000ff004853484c3630313038360a2020004f";
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

    programs.emacs = {
      extraPackages = epkgs: [
        pkgs.mu
      ];
    };

    home = {
      inherit username homeDirectory;
      stateVersion = "22.05";

      packages = defaultPkgs;

      file = {
        ".my-emacs" = {
          source = ./homes/.my-emacs;
          recursive = true;
        };
        ".emacs-profiles.el" = {
          source = ./homes/.emacs-profiles.el;
        };
        ".emacs-profile" = {
          source = ./homes/.emacs-profile;
        };
        ".emacs.d" = {
          source = ./homes/.emacs.d;
          recursive = true;
        };
      };

      sessionVariables = {
        DISPLAY = ":0";
        EDITOR = "nvim";
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
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
  };
}
