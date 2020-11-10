final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "a4fea2884dae63d218179035981d2edfa21fda91";
      sha256 = "sha256-j3F7AfZgvoKGkxXN/gcFRNYtvVeEA5Y538iMcqA24qQ=";
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
