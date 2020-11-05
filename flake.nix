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

  outputs = { self, home-manager, nixpkgs, ... }: rec{
    nixosConfigurations = {

      watchmen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thiago = import ./home/home.nix;
          }
          ./overlays
        ];
      };

    };
  };
}
