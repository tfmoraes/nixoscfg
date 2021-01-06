final: prev: {
  # neovim-unwrapped = prev.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    # pname = "neovim-unwrapped";
    # version = "0.5.0";
    # name = "${pname}-${version}";
    # src = prev.pkgs.fetchFromGitHub {
      # owner = "neovim";
      # repo = "neovim";
      # rev = "a1ed941a7881122fda2fd48e71e890ed55e4d08e";
      # sha256 = "sha256-mt5e0CWYncJGNQlO318cotv0vx5LOUxc12taFOf71i0=";
    # };
    # buildInputs = oldAttrs.buildInputs ++ [ prev.pkgs.tree-sitter ];
  # });

  neovim = prev.wrapNeovim prev.neovim-nightly {

    extraPython3Packages = (ps: with ps; [
      pynvim
      black
      isort
      pylint
    ]);

    extraPythonPackages = (ps: with ps; [
      pynvim
    ]);

    withNodeJs = true;

    withRuby = true;

  };
}
