# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # ./polybar.nix
    ./gnupg.nix
  ];

  # TODO: Set your username
  home = {
    username = "vermium";
    homeDirectory = "/home/vermium";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
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
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  services.dunst.enable = true;

  programs.gpg.enable = true;

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = {
      "bar/top" = {
        monitor = "eDP1";
        width = "100%";
        height = "3%";
        radius = 0;
        # Just sticking them together in the center for now
        modules-center = "date i3";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
      "module/i3" = {
        type = "internal/i3";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
      };
    };
    script = ''
    polybar top &
    '';
  };

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "tty";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
