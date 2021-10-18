final: prev: {
  egl-wayland = prev.egl-wayland.overrideAttrs (old: rec {
    pname = "egl-wayland";
    version = "1.1.9";
    name = "${pname}-${version}";
    src = final.fetchFromGitHub {
      owner = "Nvidia";
      repo = "egl-wayland";
      rev = "1.1.9";
      sha256 = "sha256-rcmGVEcOtKTR8sVkHV7Xb+8NuKWUapYn+/Fswi4z6Mc=";
    };
    buildInputs = old.buildInputs ++ [ final.wayland-protocols ];
  });

  # xwayland = prev.xwayland.overrideAttrs (old: rec{
  #   patches = [
  #       (prev.fetchpatch {
  #         name = "766.patch";
  #         url = "https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/766.patch";
  #         sha256 = "sha256-Fqzphpa7neGOdktOxnevNPGlzwzo/yKckMvGcqHlCmM=";
  #       })
  #     ];
  # });

  # mesa = prev.mesa.overrideAttrs (old: rec{
  #   mesonFlags = old.mesonFlags ++ [
  #     "-Dgbm-backends-path=/run/opengl-driver/lib/gbm:${placeholder "out"}/lib/gbm:${placeholder "out"}/lib"
  #   ];
  # });
}
