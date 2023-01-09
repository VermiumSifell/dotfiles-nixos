{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  home-manager = inputs.home-manager;
in
{
  AxelLaptop01 = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/AxelLaptop01
      ../system/configuration.nix
               home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vermium = { config, pkgs, ... }: import ./home/home.nix { inherit config pkgs; };
          }
    ];
  };
}