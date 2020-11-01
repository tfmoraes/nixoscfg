self: super: {
  ocaml-sha = super.stdenv.mkDerivation rec {
    pname = "ocaml-sha";
    version = "1.13";
    src = super.fetchFromGitHub rec {
      owner = "djs55";
      repo = "ocaml-sha";
      rev = "v${version}";
      sha256 = "0z1mrc4rvxvrgahxc4si6mcm5ap45fsxzmpdifylaxavdfcaqz1b";
    };
    buildInputs = with super; [
      dune_2
      ocaml
      ocamlPackages.ounit
      ocamlPackages.ocaml_extlib
      ocamlPackages.findlib
    ];

    prePatch = ''
      substituteInPlace Makefile --replace "dune build --dev @install" "dune build @install"
      substituteInPlace Makefile --replace "dune build @doc" "dune build"
      substituteInPlace Makefile --replace ".PHONY: all test doc install uninstall clean" ".PHONY: all test install uninstall clean"
      substituteInPlace dune-project --replace "(generate_opam_files true)" "(generate_opam_files false)"
      '';

    buildPhase = ''
      dune build
    '';

    installPhase = ''
      dune install --mandir=$out
    '';

  };

  haxe = super.haxe.overrideAttrs (oldAttrs: rec {
    pname = "haxe";
    version = "4.1.3";
    name = "${pname}-${version}";
    src = super.fetchFromGitHub rec {
      owner = "HaxeFoundation";
      repo = "haxe";
      rev = "${version}";
      sha256 = "0yfpvsw7xfs6296r3l07nvz82hg0lm6r8wnvg13gqbl01wldj570";
      # fetchSubmodules = true;
    };
    buildInputs = with super; [
      dune_2
      ocaml
      pcre
      zlib
      ocamlPackages.ocaml_extlib
      ocamlPackages.findlib
      ocamlPackages.batteries
      ocamlPackages.sedlex_2
      ocamlPackages.ptmap
      ocamlPackages.ppx_derivers
      ocamlPackages.xml-light
      ocamlPackages.cryptokit
      ocamlPackages.digestif
      ocamlPackages.dune-private-libs
      ocaml-sha
    ];
    prePatch = null;
  });
}
