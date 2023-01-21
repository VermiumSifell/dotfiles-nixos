{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (lib.hiPrio traceroute)
    inetutils
    ipcalc
    wireshark
    nmap
    dsniff
    tcpdump
    wireguard-tools
    bind
    networkmanagerapplet
  ];
}
