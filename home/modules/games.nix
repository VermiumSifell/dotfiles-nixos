{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ## Games
    minecraft
    bastet

    ## Launchers
    prismlauncher
    lutris

    ## Utilities
    protontricks
  ];
}
