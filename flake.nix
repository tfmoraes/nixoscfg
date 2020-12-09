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

  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: rec{
      common = {
        nix.nixPath = [
          "nixpkgs=${nixpkgs}"
        ];
        nix.registry.nixpkgs.flake = nixpkgs;
      };
    nixosConfigurations = {
      watchmen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/configuration.nix
          ./overlays
          common
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thiago = import ./home/home.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };

    };
  };
}
