{ inputs, config, system, ... }:

with inputs;

let
  nixosSystem = nixpkgs.lib.nixosSystem;
in
{
  AxelLaptop01 = nixosSystem {
    inherit system config pkgs;

    nixpkgs.overlays = [ nur.overlay ];

    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/AxelLaptop01
      ../system/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.vermium = { config, pkgs, ... }: import ../home/home.nix { inherit inputs config pkgs system; };
      }
    ];
  };
}
