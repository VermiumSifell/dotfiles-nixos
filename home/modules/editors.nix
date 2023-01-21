{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ vim vscodium neovim ];
}
