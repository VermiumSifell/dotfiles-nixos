{ config, lib, pkgs, ... }:

{
  home.packages=with pkgs;[
    (pkgs.nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })
  ];
}
