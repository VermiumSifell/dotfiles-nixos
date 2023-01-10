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

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          modules = [
            ./machines/AxelLaptop01/configuration.nix
            ./machines/AxelLaptop01/hardware.nix
            ./machines/AxelLaptop01/home
          ];
        };
      };
    };
}
