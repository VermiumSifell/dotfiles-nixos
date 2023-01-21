{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker
    docker-compose
    postman
    rnix-lsp
    nixfmt
    direnv
    nixpkgs-fmt
  ];
}
