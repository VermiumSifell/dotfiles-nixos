{
  description = "Vermium's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.overlays = [ nur.overlay ]; }
            home-manager.nixosModules.home-manager
            ./machines/AxelLaptop01/configuration.nix
            ./machines/AxelLaptop01/hardware.nix
            ./machines/AxelLaptop01/home
          ];
        };
      };
    };
}
