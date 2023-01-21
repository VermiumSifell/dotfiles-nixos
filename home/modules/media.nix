{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ spotify vlc gimp libreoffice renoise ];
}
