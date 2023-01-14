{ config, lib, pkgs, ... }:

{
  users.users = {
    vermium = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" ];

      initialPassword = "welcome";
    };
  };
}
