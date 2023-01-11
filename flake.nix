{
  description = "Vermium's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        # Configuration for AxelLaptop01
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager
            ./machines/AxelLaptop01/configuration.nix
            ./machines/AxelLaptop01/hardware.nix
            ./machines/AxelLaptop01/home
          ];
        };

        # Configuration for AxelLaptop02
        AxelLaptop02 = nixpkgs.lib.nixosSystem {
          modules = [
            home-manager.nixosModules.home-manager
            ./machines/AxelLaptop02/configuration.nix
            ./machines/AxelLaptop02/hardware.nix
            ./machines/AxelLaptop02/home
          ];
        };

      };
    };
}
