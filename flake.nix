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

  outputs = { self, nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem
          {
            modules = [
              home-manager.nixosModules.home-manager
              ./machines/AxelLaptop01/configuration.nix
              ./machines/AxelLaptop01/hardware.nix
              ./machines/AxelLaptop01/home
            ];
          };
      };
    };
}
