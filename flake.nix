{
  description = "Vermium's Home Manager & NixOS configurations";

  # Dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager }:
    let
      system = "x86_64-linux";

      gtk-theme = {
        name = "Materia-dark";
        package = nixpkgs.legacyPackages.${system}.materia-theme;
      };

    in
    {
      nixosConfigurations = {
        AxelLaptop01 = nixpkgs.lib.nixosSystem
          {
            inherit system;


      modules = let
        nur-modules = import nur {
          nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      in [
       { imports = [ nur-modules.repos.paul ]; }
      ];

            # modules = [
            #   {
            #     imports = [
            #       nur.repos.paul.modules.foo
            #       ./system/configuration.nix
            #       home-manager.nixosModules.home-manager
            #       {
            #         home-manager.useGlobalPkgs = true;
            #         home-manager.useUserPackages = true;
            #         home-manager.users.vermium = { config, pkgs, ... }: import ./home/home.nix { inherit gtk-theme config pkgs; };
            #       }


            #     ];
            #   }
            # ];


          };
      };
    };
}
