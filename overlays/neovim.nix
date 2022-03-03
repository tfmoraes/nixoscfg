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

  # neovim = prev.wrapNeovimUnstable prev.neovim-nightly {

  #   python3Env = final.python3.withPackages (ps: with ps; [
  #     pynvim
  #     black
  #     isort
  #     pylint
  #   ]);

  #   withPython2 = false;
  #   withPython3 = true;
  #   withNodeJs = true;
  #   withRuby = true;
  #   wrapRc = false;
  #   manifestRc = ''
  #     let g:python3_host_prog = "nvim-python3"
  #   '';

  # };

  # neovim-qt-unwrapped = prev.neovim-qt-unwrapped.overrideAttrs (old: {
  #   src = prev.fetchFromGitHub {
  #     owner = "equalsraf";
  #     repo = "neovim-qt";
  #     rev = "85ade6728307645a22491d3673af06e82d2ee909";
  #     sha256 = "sha256-EhYEPcqsJbW4Bc/zHhjcXIv504veQQ4HNXXa09pbnQ8=";
  #   };
  # });
}
