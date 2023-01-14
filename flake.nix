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

      wallpaper = ./wallpapers/nord-rainbow-dark-nix.png;

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
            home-manager.nixosModules.home-manager
            ./common/users.nix
            ./machines/AxelLaptop01/configuration.nix
            ./machines/AxelLaptop01/hardware-configuration.nix
            ./home/home.nix
          ];
        };

        AxelLaptop02 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs // { inherit wallpaper gtk-theme; };

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay ]; })
            home-manager.nixosModules.home-manager
            ./common/users.nix
            ./machines/AxelLaptop02/configuration.nix
            ./machines/AxelLaptop02/hardware-configuration.nix
            ./home/home.nix
          ];
        };
      };
    };
}
