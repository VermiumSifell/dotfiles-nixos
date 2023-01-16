{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Vermium Sifell";
    userEmail = "vermium@zyner.org";
    signing = {
      key = "844A1E9F64F6E1CE";
      signByDefault = true;
    };
  };
}
