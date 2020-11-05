self: super: {
  python3 = super.python3.override {
    packageOverrides = import ./pkgs/python_overlays.nix;
    self = super.python3;
  };

  python37 = super.python37.override {
    packageOverrides = import ./pkgs/python_overlays.nix;
    self = super.python37;
  };

  python38 = super.python38.override {
    packageOverrides = import ./pkgs/python_overlays.nix;
    self = super.python38;
  };
}
