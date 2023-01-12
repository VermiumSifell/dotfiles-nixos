{ inputs, lib, config, pkgs, ... }:

{
  # TODO: Redo this part
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./programs.nix
  ];

  hardware = {
    nvidia.prime = {
      sync.enable = true;

      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };

    bluetooth.enable = true;

    opengl.enable = true;
    opengl.driSupport32Bit = true;
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
    };
  };

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "AxelLaptop01";
    networkmanager.enable = true;
  };

  users.users = {
    vermium = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  security = {
    rtkit.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
