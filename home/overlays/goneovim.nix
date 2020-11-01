self: super: {
  goneovim = super.callPackage ./pkgs/goneovim {
    qtbase = super.qt5.qtbase;
  };
}
