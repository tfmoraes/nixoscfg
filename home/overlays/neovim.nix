self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideDerivation (oldAttrs: rec{
    pname = "neovim-unwrapped";
    version = "0.5.0";
    name = "${pname}-${version}";
    src = super.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "98024853f4755f51e82526b45484bae0ec6042ba";
      sha256 = "MOCvIwzbQGVvzjaBzSuWoeSb7B/cIOGPcWUymu4UHTY=";
    };
  });

  neovim = super.neovim.override {
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
