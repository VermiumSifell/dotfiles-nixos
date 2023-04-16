{ inputs, lib, config, pkgs, wallpaper, gtk-theme, ... }:

{
  imports = [
    ../base/users.nix
    ../base/bootloader.nix
    ../base/virtualisation.nix
    ../base/hardware.nix
    ../base/audio.nix
  ];

  # Make sure that other operating systems show up aswell
  boot.loader.grub.useOSProber = true;

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "AxelLaptop02";
    networkmanager.enable = true;
  };

  security = {
    rtkit.enable = true;
    pam = {
      services = {
        lightdm = { enableGnomeKeyring = true; };
        login = { enableGnomeKeyring = true; };
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "se";

      libinput = {
        enable = true;
        touchpad.tapping = true;
      };

      displayManager = {
        lightdm = {
          enable = true;
          background = wallpaper;
          greeters.gtk.theme = gtk-theme;
        };
        defaultSession = "none+i3";
      };
      windowManager = {
        i3 = {
          enable = true;
          extraSessionCommands = ''
            eval $(gnome-keyring-daemon --daemonize)
            export SSH_AUTH_SOCK
          '';
        };
        awesome.enable = true;
      };
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    gnome.gnome-keyring.enable = true;
    autorandr.enable = true;
    blueman.enable = true;
    tlp.enable = true;
    greenclip.enable = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  programs = {
    dconf.enable = true;
    slock.enable = true;
    seahorse.enable = true;

    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      dmenu
      libnotify
      slock
      playerctl
      rofi
      brightnessctl
      feh
      pulseaudio
      rofi-bluetooth
      git
    ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
