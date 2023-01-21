{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ lutris bastet minecraft prismlauncher ];
}
