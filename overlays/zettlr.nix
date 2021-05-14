self: super: {
  zettlr = super.callPackage ./pkgs/zettlr {
    texlive = super.texlive.combined.scheme-medium;
  };
}
