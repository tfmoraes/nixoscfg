final: prev: {
  egl-wayland = prev.egl-wayland.overrideAttrs (old: rec {
    pname = "egl-wayland";
    version = "1.1.8";
    name = "${pname}-${version}";
    src = prev.fetchFromGitHub {
      owner = "Nvidia";
      repo = "egl-wayland";
      rev = "1.1.8";
      sha256 = "sha256-PSttnvjXni5w2QBLnNYA4Ptl7stzMT/SRZvdpCnD4aY=";
    };
    buildInputs = old.buildInputs ++ [ prev.wayland-protocols ];
  });
}
