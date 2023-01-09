{ pkgs, ... }: {
  programs.dunst = {
    enable = true;
    configFile = "./dunstrc";
  };
}
