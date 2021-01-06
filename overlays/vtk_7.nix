final: prev: {
  vtk_7 = prev.vtk_7.overrideAttrs (oldAttrs: rec {
    patches = oldAttrs.patches ++ [
      (prev.fetchpatch{
        url = "https://gitweb.gentoo.org/repo/gentoo.git/plain/sci-libs/vtk/files/vtk-8.2.0-gcc-10.patch?id=c4256f68d3589570443075eccbbafacf661f785f";
        sha256 = "0bpwrdfmi15grsg4jy7bzj2z6511a0c160cmw5lsi65aabyh7cl5";
      })
    ];
  });
}
