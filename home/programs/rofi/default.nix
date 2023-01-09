{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rasi;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
      haskellPackages.greenclip
    ];
  };
}