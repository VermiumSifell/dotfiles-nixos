# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
    enableSSHSupport = true;
  };
}
