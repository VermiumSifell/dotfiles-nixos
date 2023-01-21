{
  description = "Vermium's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/nur";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, nix-doom-emacs, home-manager, ... }@attrs:
    let
      system = "x86_64-linux";

      wallpaper = ./wallpapers/nord-gray-mountains.png;

      gtk-theme = {
        name = "Materia-dark";
        package = nixpkgs.legacyPackages.${system}.materia-theme;
      };

    in {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs // { inherit wallpaper gtk-theme; };

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay ]; })
            ./machines/AxelLaptop01/hardware-configuration.nix
            ./machines/AxelLaptop01/configuration.nix
            home-manager.nixosModules.home-manager
            ./home/machines/AxelLaptop01.nix
          ];
        };

        AxelLaptop02 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs // { inherit wallpaper gtk-theme; };

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay ]; })
            ./machines/AxelLaptop02/hardware-configuration.nix
            ./machines/AxelLaptop02/configuration.nix
            home-manager.nixosModules.home-manager
            ./home/machines/AxelLaptop02.nix
          ];
        };
      };
    };
}
