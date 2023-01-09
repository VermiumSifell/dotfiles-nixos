{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in
{
  AxelLaptop01 = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs home-manager; };
    modules = [
      ../system/machine/AxelLaptop01
      ../system/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.vermium = { config, pkgs, ... }: import ./home/home.nix { inherit gtk-theme config pkgs; };
      }
    ];
  };
}
