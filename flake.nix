{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
        AxelLaptop01-nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ nur.overlay overlay-packages ]; })
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.vermium = { config, pkgs, ... }: import ./home-manager/home.nix { inherit gtk-theme config pkgs; };
            }
          ];
        };
      };
    };
}
