{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ discord signal-desktop element-desktop ];
}
