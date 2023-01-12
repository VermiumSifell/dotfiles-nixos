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

      wallpaper = ./wallpapers/clean.png;

      gtk-theme = {
        name = "Materia-dark";
        package = nixpkgs.legacyPackages.${system}.materia-theme;
      };

    in
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs // { inherit wallpaper gtk-theme; };

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay ]; })
            home-manager.nixosModules.home-manager
            ./system/configuration.nix
            ./home/home.nix
          ];
        };
      };
    };
}
