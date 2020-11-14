final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0798ad3a3a071db1b647df5aecd7698ed9aff7d9";
      sha256 = "sha256-YyBZc5d8p4ddIZzR+Z4eTFtKiwB/cYMx9FTXLx0NrEY=";
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
