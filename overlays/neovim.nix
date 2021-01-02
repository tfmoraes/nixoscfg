final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = prev.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "48caf1df8581a9a9da9072f901411b918333952d";
      sha256 = "sha256-gVyVFYMn9UF6U0UQK8oYxFltjS7YQnRKGGzdEQQ1oco=";
    };
    buildInputs = oldAttrs.buildInputs ++ [ prev.pkgs.tree-sitter ];
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
}
