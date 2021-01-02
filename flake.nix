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
    let
      mkSystem = system: hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (./. + "/host/${hostname}/configuration.nix" )
        ];
        specialArgs = { inherit inputs; };
      };

      mkHomeManagerConfiguration = system: username: home-manager.lib.homeManagerConfiguration {
        inherit system username;
          configuration = { pkgs, lib, ... }: {
            nixpkgs = {
              config = {
                allowUnfree = true;
              };
              overlays = self.overlays;
            };
            imports = [
              (./. + "/home/${username}/home.nix" )
              # ./overlays
            ];
          };
          homeDirectory = "/home/${username}/";
        };
    in
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
        watchmen = mkSystem "x86_64-linux" "watchmen";
      };

      homeManagerConfigurations = {
        thiago = mkHomeManagerConfiguration  "x86_64-linux" "thiago";
      };

      overlays = [
        (import ./overlays/neovim.nix)
        (import ./overlays/sumneko.nix)
        (import ./overlays/vimlsp.nix)
        (import ./overlays/toolbox.nix)
        (import ./overlays/python.nix)
      ];
    };
}
