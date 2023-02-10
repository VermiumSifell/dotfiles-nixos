{ config, lib, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    libvirtd = {
      enable = true;
      qemuRunAsRoot = false;
    };
  };
}
