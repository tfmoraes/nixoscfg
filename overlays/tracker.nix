final: prev: {
  tracker = prev.tracker.overrideAttrs
    (old: {
      patches = old.patches ++ prev.lib.optionals (prev.stdenv.hostPlatform.isi686) [
        (prev.fetchpatch {
          name = "i686-test.patch";
          url = "https://gitlab.gnome.org/GNOME/tracker/-/commit/af707181a2c492a794daec7ce3f3062d67ffd9dc.patch";
          sha256 = "sha256-KOdkTy79w3oiQILrPG00UVrv+VBjAk4Y868I8jtifqk=";
        })
      ];
    });
}
