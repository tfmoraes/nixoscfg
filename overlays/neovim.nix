final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "2debabb0805ccd014478e6aff88fce8129a352d0";
      sha256 = "sha256-U5LxIq9mmy0CJj6eK7vexQxB1NLUOoqci4BnIT2cRp8=";
    };

    buildInputs = oldAttrs.buildInputs ++ [ prev.pkgs.tree-sitter ];

    # nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ prev.pkgs.tree-sitter ];
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

  tree-sitter = prev.tree-sitter.overrideAttrs (oldAttrs: {
    postInstall = "PREFIX=$out make install";
  });
}
