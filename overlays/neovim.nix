final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "aec61074a97bac3290f1afef309429b35a71d1a2";
      sha256 = "sha256-VI6CBROKX6dKL8Yvg7rpy813nzg8z0W0WYapq1DEJtk=";
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
