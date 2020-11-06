final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "d17e508796be60eefe4a597df62de1fd9e7e1725";
      sha256 = "sha256-sZhGd/sUo2r223pLXzS1VOKh9SAZG4fkzqGUC3vtG2k=";
    };

    buildInputs = oldAttrs.buildInputs ++ [ prev.pkgs.tree-sitter ];

    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ prev.pkgs.tree-sitter ];
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
