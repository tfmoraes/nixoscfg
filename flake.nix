{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # jonringer_npkgs.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , flake-utils
    , ...
    }:
    let
      overlays = [
        # inputs.neovim-nightly-overlay.overlay
        (import ./overlays/neovim.nix)
        # (import ./overlays/sumneko.nix)
        # (import ./overlays/vimlsp.nix)
        # (import ./overlays/toolbox.nix)
        (import ./overlays/python.nix)
        # (import ./overlays/tracker.nix)
        # (import ./overlays/egl-wayland.nix)
        # (import ./overlays/adw-gtk3.nix)
        # (import ./overlays/bees.nix)
        # (import ./overlays/system-config-printer.nix)
        # (import ./overlays/zettlr.nix)
        # (import ./overlays/gnome-boxes.nix)
        (import ./overlays/helix.nix inputs)
      ];

      mkSystem = system: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (./. + "/host/${hostname}/configuration.nix")
            inputs.nix-ld.nixosModules.nix-ld
            (
              { pkgs, ... }: {
                nixpkgs.overlays = [
                  # (import ./overlays/tracker.nix)
                  # (import ./overlays/egl-wayland.nix)
                  # (import ./overlays/python.nix)
                  # (import ./overlays/bees.nix)
                ];
              }
            )
          ];
          specialArgs = { inherit inputs; };
        };

      mkHomeManagerConfiguration = system: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs =
            (import nixpkgs {
              inherit system;
              inherit overlays;
              config.allowUnfree = true;
            }).pkgs;
          modules = [
            (./. + "/home/${username}/home.nix")
            inputs.nix-index-database.hmModules.nix-index
            # ./overlays
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}/";
                stateVersion = "23.11";
              };
            }
          ];
        };
    in
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          scripts = import ./lib/scripts.nix { inherit pkgs; };
        in
        {
          devShell = pkgs.mkShell {
            name = "nixos-flakes";
            nativeBuildInputs = [
              pkgs.git
              pkgs.jq
              scripts.update-flake
              scripts.home-switch
              scripts.update-system
              scripts.flake-mgr
            ];
          };
        }
      )
    // {
      nixosConfigurations = {
        watchmen = mkSystem "x86_64-linux" "watchmen";
      };

      homeConfigurations = {
        thiago = mkHomeManagerConfiguration "x86_64-linux" "thiago";
      };
    };
}
