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

      neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
        pname = "neovim-unwrapped";
        version = "0.5.0";
        name = "${pname}-${version}";
        src = prev.pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "90f3a8ba291fb0583ab6b0bd33129fdd45df1dab";
          sha256 = "n59ZEeIpmbumhwLV5ET5dWGeNZ/ZDnsnSCjeZyAoo3Q=";
        };
      });

      neovim = prev.neovim.override {
        extraPython3Packages = (ps: with ps; [
          pynvim
          black
          isort
          pylint
        ]);
        extraPythonPackages = (ps: with ps; [
          pynvim
        ]);
      };
    })
  ];
}
