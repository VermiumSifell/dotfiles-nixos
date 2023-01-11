{
  description = "Vermium's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/nur";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit nur; };

            modules = [
              home-manager.nixosModules.home-manager
              {
                home-manager.sharedModules = [ nur.hmModules.nur ];
              }
              ./machines/AxelLaptop01/configuration.nix
              ./machines/AxelLaptop01/hardware.nix
              ./machines/AxelLaptop01/home
            ];
          };
      };
    };
}
