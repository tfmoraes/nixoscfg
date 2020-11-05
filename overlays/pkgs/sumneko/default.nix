{ stdenv
, lua
, fetchgit
, ninja
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "sumneko";
  version = "1.0.0";

  src = fetchgit {
    url = https://github.com/sumneko/lua-language-server.git;
    rev = "a5e60e8d423cf1e0853bb8e22a8855a423774f86";
    sha256 = "14sack8g1rvwdlv9pm9jr5gfkjyaln8r96z0rav02qsycs9csygp";
    fetchSubmodules = true;
  };

  patches = [ ./0001-Fix-paths.patch ];

  buildInputs = [
    lua
    ninja
    makeWrapper
  ];

  buildPhase = ''
    cd 3rd/luamake
    ninja -f ninja/linux.ninja
    cd ../..
    ./3rd/luamake/luamake rebuild
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/${pname}/
    cp -a bin/Linux/* $out/share/${pname}/
    cp -a main.lua $out/share/${pname}/
    cp -a libs locale script platform.lua $out/share/${pname}/
    cp ${./sumneko} $out/bin/sumneko
  '';
}
