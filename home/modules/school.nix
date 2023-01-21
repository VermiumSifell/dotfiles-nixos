{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ ciscoPacketTracer8 qalculate-qt speedcrunch ];
}
