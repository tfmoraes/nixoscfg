{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          scripts = import ./lib/scripts.nix { inherit pkgs; };
        in
        {
          devShell = pkgs.mkShell {
            name = "teste";
            nativeBuildInputs = [
              pkgs.git
              scripts.update-flake
              scripts.home-switch
              scripts.update-system
              scripts.flake-mgr
            ];
          };
        }
      ) //
    {
      nixosConfigurations = {
        watchmen = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./host/configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };

      homeManagerConfigurations = {
        thiago = home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, lib, ... }: {
            nixpkgs = {
              config = {
                allowUnfree = true;
              };
            };
            imports = [
              ./home/home.nix
              ./overlays
            ];
          };
          system = "x86_64-linux";
          homeDirectory = "/home/thiago/";
          username = "thiago";
        };
      };
    };
}
