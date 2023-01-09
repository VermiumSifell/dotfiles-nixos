{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./services.nix
    ./programs.nix
  ];

  networking = {
    hostName = "AxelLaptop01";
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "Europe/Stockholm";

  services.greenclip.enable=true;


  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  # Enable i3wm.
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  programs.zsh.enable = true;

  users.users = {
    vermium = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  hardware = {
    nvidia.prime = {
      sync.enable = true;

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";

      # Bus ID of the AMD GPU. You can find it using lspci, either under 3D or VGA
      amdgpuBusId = "PCI:5:0:0";
    };

    bluetooth.enable = true;

    opengl.enable = true;
    opengl.driSupport32Bit = true;

  };

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
