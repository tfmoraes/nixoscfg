final: prev: {
  # clisp = prev.clisp.override{readline = prev.readline6;};
  # egl-wayland = prev.egl-wayland.overrideAttrs (old: rec {
  #   pname = "egl-wayland";
  #   version = "1.1.9.999";
  #   name = "${pname}-${version}";
  #   src = final.fetchFromGitHub {
  #     owner = "Nvidia";
  #     repo = "egl-wayland";
  #     rev = "daab8546eca8428543a4d958a2c53fc747f70672";
  #     sha256 = "sha256-IrLeqBW74mzo2OOd5GzUPDcqaxrsoJABwYyuKTGtPsw=";
  #   };
  #   buildInputs = old.buildInputs ++ [ final.wayland-protocols ];
  # });


  # xwayland = prev.xwayland.overrideAttrs (old: rec{
  #   version = "21.1.2.901";
  #   src = prev.fetchFromGitLab {
  #     domain = "gitlab.freedesktop.org";
  #     owner = "xorg";
  #     repo = "xserver";
  #     rev = "xwayland-21.1.2.901";
  #     sha256 = "sha256-TOsxN+TVMICYhqkypqrFgzI/ln87ALb9LijPgHmlcos=";
  #   };
  # });

  # gnome = prev.gnome.overrideScope' (selfx: superx: {
  #   mutter = superx.mutter.overrideAttrs (old: {
  #     mesonFlags = [
  #       "-Degl_device=true"
  #       "-Dinstalled_tests=false" # TODO: enable these
  #       "-Dwayland_eglstream=false"
  #       "-Dprofiler=true"
  #       "-Dxwayland_path=${final.xwayland}/bin/Xwayland"
  #       # This should be auto detected, but it looks like it manages a false
  #       # positive.
  #       "-Dxwayland_initfd=disabled"
  #     ];
  #   });
  # });

  # mesa = prev.mesa.overrideAttrs (old: rec{
  #   mesonFlags = old.mesonFlags ++ [
  #     "-Dgbm-backends-path=/run/opengl-driver/lib/gbm:${placeholder "out"}/lib/gbm:${placeholder "out"}/lib"
  #   ];
  # });
}
