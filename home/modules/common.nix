{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ xfce.thunar virt-manager xclip maim ];
}
