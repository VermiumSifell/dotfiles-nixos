{ config, lib, pkgs, ... }:

{
  hardware = {
    bluetooth.enable = true;

    opengl.enable = true;
    opengl.driSupport32Bit = true;
  };
}
