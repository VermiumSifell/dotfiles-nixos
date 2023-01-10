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

  outputs = { nixpkgs, nur, home-manager, ... }@attrs:
    let
      system = "x86_64-linux";

      gtk-theme = {
        name = "Materia-dark";
        package = nixpkgs.legacyPackages.${system}.materia-theme;
      };

    in
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          modules = [
            ./machines/AxelLaptop01/configuration.nix
            ./machines/AxelLaptop01/hardware.nix
            ./machines/AxelLaptop01/home.nix
          ];
        };
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay ]; })
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.vermium = import ./home/home.nix
                }
                ];
            };
            };
            };
            }
