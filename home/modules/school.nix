{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ ciscoPacketTracer8 ];
}
