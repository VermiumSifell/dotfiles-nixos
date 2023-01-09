{ inputs, system, ... }:

with inputs;

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;

  nixpkgs.overlays = [ nur.overlay ];

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
        home-manager.users.vermium = { pkgs, ... }: import ../home/home.nix { inherit inputs pkgs system; };
      }
    ];
  };
}
