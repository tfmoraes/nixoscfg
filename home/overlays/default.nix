{ config, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      sumneko = prev.callPackage ./pkgs/sumneko { };
      vimlsp = prev.callPackage ./pkgs/vimlsp { };
      toolbox = prev.callPackage ./pkgs/toolbox { };

      python3 = prev.python3.override {
        packageOverrides = import ./pkgs/python_overlays.nix;
        self = prev.python3;
      };

      python37 = prev.python37.override {
        packageOverrides = import ./pkgs/python_overlays.nix;
        self = prev.python37;
      };

      python38 = prev.python38.override {
        packageOverrides = import ./pkgs/python_overlays.nix;
        self = prev.python38;
      };


    })

    (import ./neovim.nix)
  ];
}
