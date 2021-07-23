final: prev: {
  system-config-printer = prev.system-config-printer.overrideAttrs (oldAttrs: rec {
    src = prev.fetchFromGitHub {
      owner = "openPrinting";
      repo = "${oldAttrs.pname}";
      rev = "v${oldAttrs.version}";
      sha256 = "0a3v8fp1dfb5cwwpadc3f6mv608b5yrrqd8ddkmnrngizqwlswsc";
    };
    patches = [
      (prev.lib.take 1 oldAttrs.patches)
    ];
    preConfigure = ''
      intltoolize --copy --force --automake
    '';
  });
}
